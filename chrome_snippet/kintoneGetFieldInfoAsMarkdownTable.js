/**
 * @fileoverview アプリのフィールド情報を Markdown 形式で出力するスクリプト
 *
 * Usage:
 *   kintone の任意のアプリページを開いて、以下を実行する。
 */

async function prop() {
  var prop = await kintone
    .api("/k/v1/app/form/fields.json", "GET", { app: kintone.app.getId() })
    .then(r => {
      
      // 各カラム情報をまとめた配列を作成
      var result = [];
      for (const [field, value] of Object.entries(r.properties)) {
        var item = {};
        item['label'] = value.label;
        item['code'] = field;
        item['type'] = value.type;
        item['required'] = value.required;
        result.push(item);
      }
      // console.log(result)

      // 各カラム情報を Markdown のテーブル形式で出力
      var table = [];
      table.push(['| フィールド名 | フィールドコード | フィールドタイプ | 必須項目か否か |'])
      table.push(['| --- | --- | --- | --- |'])
      for(const value of result) {
        table.push([`| ${value.label} | ${value.code} | ${value.type} | ${value.required} |`])
      }      
      console.log(table.join('\n'))
    });
}
prop();