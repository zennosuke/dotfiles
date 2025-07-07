/**
 * @fileoverview kintone の内部 API を実行するスクリプト
 *
 * Usage:
 *   kintone の任意のアプリページを開いて、kintone.api() メソッドの引数に以下を入力後実行する。
 *   第一引数：`/k/` から始まるエンドポイント（例：/k/api/app/42385/record/1285/getWithAcl）
 *   第二引数：メソッド
 */

async function prop() {
  var prop = await kintone
    .api('/k/api/app/42385/record/1285/getWithAcl', 'POST', {'hasAccessedKintone':true})
    .then(r => console.log(r));
}
prop();