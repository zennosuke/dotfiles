/**
 * @fileoverview 全ユーザーの氏名、ログイン ID、メールアドレスを取得するスクリプト
 *
 * 使い方
 * 1. Google ChromeかFirefoxでkintoneの任意のページを開く(例. https://bozuman.cybozu.com/k/)
 * 2. 開発コンソールでこのスクリプトを実行する
 */

(async () => {
  let count = 0;
  const USER_URL = '/v1/users.json';
  const results = [];

  while (true) {
    let offset = count;
    const body = {
      size: 100,
      offset: offset
    };

    const resp = await kintone.api(kintone.api.url(USER_URL, false), 'GET', body);

    if (resp.users.length === 0) {
      break;
    }
    console.log(resp)
    const usersArr = resp.users.map(user => ({loginId: user.code, email: user.email, name: user.name}));
    results.push(usersArr);
    count += resp.users.length;
  }

  console.log(results.flat());
})()
