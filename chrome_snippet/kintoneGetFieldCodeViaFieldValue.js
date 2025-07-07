// フィールド名からフィールドコードを取得
async function getFieldCodeByLabel(label) {
  const prop = await kintone
    .api("/k/v1/app/form/fields.json", "GET", { app: kintone.app.getId() })
    .then((r) => r.properties);
  return Object.keys(prop).filter((key) => prop[key].label === label);
}

const labels = [
  "Date",
  "Persona",
  "Reported by",
  "Sales Lead #",
  "No Show (Initial Meeting ONLY)",
  "Activity",
  "Sales Status",
  "Pre Sales Detail",
  "Post Sales Details",
  "IM Done Details",
  "Expt. IM Date",
  "Current Post Sales Details",
  "Company Name(Sales Database)",
  "Partner Lookup",
  "Related Outbound Campaign",
  "Currently Use",
  "CS Purpose",
  "ERP",
  "Use Case",
  "Competitors",
  "NPO",
  "Deal Closing Requirements (Only Use when Closing the Deal)",
  "Lead Lost Reason",
  "Expansion KPI",
  "Type of UpSell",
  "Hubspot Contact ID"
];
for (const label of labels) {
  console.log(`Label: ${label}, \nFieldCode: ${await getFieldCodeByLabel(label)}`)
  // console.log(await getFieldCodeByLabel(label))
}