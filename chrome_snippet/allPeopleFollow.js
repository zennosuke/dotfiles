/**
 * @fileoverview kintoneで全員フォローするスクリプト
 *
 * 使い方
 * 1. Google ChromeかFirefoxでkintoneの任意のページを開く(例. https://bozuman.cybozu.com/k/)
 * 2. 開発コンソールでこのスクリプトを実行する
 */

const USER_URL = '/k/api/group/users.json';
const SUBSCRIBE_URL = '/k/api/people/user/subscribe.json';
const TOKEN = kintone.getRequestToken();

function postJson(url, data) {
  return fetch(url, {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(Object.assign({'__REQUEST_TOKEN__': TOKEN}, data)),
  }).then(response => {
    if (response.status >= 200 && response.status < 300) {
      return response.json();
    } else {
      return Promise.reject(new Error(response.statusText));
    }
  })
}

function getUsers(offset) {
  return postJson(USER_URL, {
      'id': '7532782697181632513',
      'size': 100,
      'offset': offset,
  })
  .then(resp => resp.result.entities);
}

function subscribeUser(user) {
  console.log('Following... ' + user.name);
  return postJson(SUBSCRIBE_URL, {
      'userId': user.id,
      'subscribe': true,
  });
}

(async () => {
  let offset = 0;
  let total = 0;
  while (true) {
    const count = await getUsers(offset)
      .then(entities => {
	return entities
	  .filter(entity => entity.id !== kintone.getLoginUser().id)
	  .map(entity => subscribeUser(entity));
      })
      .then(subscribings => Promise.all(subscribings))
      .then(result => {
        return result.length
    });

    if (count === 0) {
      break;
    }
    total += count;
    offset += count;
  }

  console.log(`Done! Now following ${total} users.`);
})()