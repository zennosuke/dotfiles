/**
 * 複数の Garoon スケジュールの参加者を重複排除してリストアップする
 *
 * Usage:
 *   1. Garoon の任意のページを開く
 *   2. 取得対象のスケジュール ID を SCHEDULE_IDS に指定する
 *   3. 開発者ツール > コンソール で以下を実行
 */

// 勉強会のスケジュール ID 
const SCHEDULE_IDS = ['3495853','3519661','3519679','3519682','3519690'];

// CSRF トークンを取得
const token = garoon.base.request.getRequestToken();

// 全ての勉強会に参加した参加者の Code を取得
const ids = [];
for (const id of SCHEDULE_IDS) {
  const res = await fetch(`/g/api/v1/schedule/events/${id}?fields=attendees`, {
    headers: {
      "X-Requested-With": token,
    },
  }).then((r) => r.json());
	const attendeeIds = res.attendees.map(r => r.code)
	ids.push(...attendeeIds);
}

// 重複排除した参加者の Code を出力
const distinctIds = new Set(ids);
console.log([...distinctIds]);

