// タスク管理アプリを開き、開発者ツールのConsoleから以下を実行
const records = await kintone.api("/k/v1/records.json", "GET", {
  app: kintone.app.getId(),
  fields: ["$id", "概要"],
  query:
    // 実行前に日付を任意に修正する
    '対応終了日 >= "2024-07-01" and 対応終了日 <= "2024-07-31" order by $id asc',
}).then((r) => r.records);
let text = "";
for (const record of records) {
  text += `- KanaimaTask-${record["$id"].value}: ${record["概要"].value}\n`;
}
console.log(text);
