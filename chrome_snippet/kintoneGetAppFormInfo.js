async function prop() {
  var prop = await kintone
    .api("/k/v1/form.json", "GET", { app: kintone.app.getId() })
    .then(r => {
            console.log(r);
    });
}
prop();