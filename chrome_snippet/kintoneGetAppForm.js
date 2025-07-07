/**
 * @fileoverview アプリのフィールドのメタ情報【計算式や必須項目かなど】を確認する
 *
 * Usage:
 *   kintone の任意のアプリページを開いて、以下を実行する。
 */
async function prop() {
  var prop = await kintone
    .api("/k/v1/form.json", "GET", { app: kintone.app.getId() })
    .then(r => {
      // 確認したいフィールドのフィールドコードをセットする
      var field_codes = ['App_created_except_Tutorial', 'App_created_Tutorial_included', 'Record_created_except_Tutorial', 'Record_created_Tutorial_included', 'FT_status_except_Tutorial'];
      console.log(r.properties.filter(field => field_codes.includes(field.code)))
    });
}
prop();