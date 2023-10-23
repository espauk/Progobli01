# Definisjoner: basisrektangler
rodRekt = rectangle(220, 160, "solid", "red")
hvitVertRekt = rectangle(40, 160, "solid", "white")
hvitHorRekt = rectangle(220, 40, "solid", "white")
blaVertRekt = rectangle(20, 160, "solid", "blue")
blaHorRekt = rectangle(220, 20, "solid", "blue")

# Design: 
flaggDesign = overlay-xy(blaHorRekt, 0, -70,
  overlay-xy(blaVertRekt, -70, 0,
    overlay-xy(hvitHorRekt, 0, -60,
      overlay-xy(hvitVertRekt, -60, 0,
        rodRekt))))

flaggDesign
