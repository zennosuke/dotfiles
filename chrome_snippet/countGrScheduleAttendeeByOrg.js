/**
 * Garoon スケジュールの参加者を「優先する組織」ごとにカウントする
 *
 * Usage:
 *   1. スケジュールを開く
 *   例: https://bozuman.cybozu.com/g/schedule/view.csp?event=3519661
 *   2. 開発者ツール > コンソール で以下を実行
 */

// CSRF トークンを取得
var token = garoon.base.request.getRequestToken();

// スケジュールの参加者の code を取得
var { attendees } = garoon.schedule.event.get();
var attendeesCodes = attendees.map((attendee) => attendee.code);

// 全ユーザーの code と primaryOrganization（優先する所属組織）を取得
var allUsers = [];
while (allUsers.length % 100 === 0) {
  var { users } = await fetch(`/v1/users.json?offset=${allUsers.length}`, {
    headers: {
      "X-Requested-With": token,
    },
  }).then((r) => r.json());

  for (var user of users) {
    allUsers.push({
      code: user.code,
      primaryOrgId: user.primaryOrganization,
    });
  }
}

// Garoon API で取得したスケジュールの参加者の「優先する組織」の組織名を取得
var attendeeOrgs = [];
for (var attendeeCode of attendeesCodes) {
  // Garoon API で取得したスケジュールの参加者と、
  // User API で取得したユーザーの「優先する組織」を紐付
  var { primaryOrgId } = allUsers.filter(
    (user) => user.code === attendeeCode
  )[0];

  // スケジュールの参加者の所属組織一覧を取得
  var org = await fetch(`/v1/user/organizations.json?code=${attendeeCode}`, {
    headers: {
      "X-Requested-With": token,
    },
  }).then((r) => r.json());

  // 「優先する組織」の組織名を取得
  var primaryOrgName = org.organizationTitles.filter(
    (title) => title.organization.id === primaryOrgId
  )[0].organization.name;

  attendeeOrgs.push({
    code: attendeeCode,
    org: primaryOrgName,
  });
}

// 「優先する組織」の組織名ごとにカウント
var result = attendeeOrgs
  .reduce((accumulator, currentValue) => {
    var { org } = currentValue;
    if (accumulator.filter((obj) => obj.org === org).length === 0) {
      accumulator.push({
        org: org,
        count: 1,
      });
    } else {
      accumulator.filter((obj) => obj.org === org)[0].count += 1;
    }
    return accumulator;
  }, [])
  .sort((a, b) => b.count - a.count)
  .reduce((accumulator, currentValue) => {
    accumulator += `人数: ${currentValue.count}\t組織: ${currentValue.org}\n`;
    return accumulator;
  }, "");

console.log(result);