</script>
// ── Load all countries ──────────────────────────────────────
fetch('http://localhost/Satellite_Imagery_System/php/get_countries.php')
  .then(res => res.json())
  .then(countries => console.log(countries));

// ── Load images filtered by country ────────────────────────
fetch('http://localhost/Satellite_Imagery_System/php/get_images.php?country_id=1')
  .then(res => res.json())
  .then(images => console.log(images));

// ── Login ───────────────────────────────────────────────────
fetch('http://localhost/Satellite_Imagery_System/php/login.php', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ email: "user@mail.com", password: "pass123" })
})
  .then(res => res.json())
  .then(data => {
    if (data.success) {
      console.log("Logged in as:", data.user.Role);
    }
  });
