include color
include tables

fun lag-nordisk-flagg(nordisk-nasjon :: String):
  doc: "Tar et Nordisk nasjon som input og returnerer et bilde av valgt nasjonal-falgg."

  # Definerer flagg-tabaell. Farger, proposjoner, breddeforhold. 
  flagg-tabell = table: nasjon :: String, farger :: List<Color>, proposjoner :: List<Number>, breddeforhold :: List<Number>

    # Data om de ulike flaggene.
  row: "norge", [list: color(186, 12, 47, 1), white, color(0, 32, 91, 1)], [list: 22, 16], [list: 6, 4]
  row: "sverige", [list: color(0, 106, 167, 1), color(254, 204, 2, 1)], [list: 16, 10], [list: 4, 2, 5]
  row: "danmark", [list: color(224, 24, 54, 1), white], [list: 37, 28], [list: 12, 4]
  row: "færøyene", [list: white, color(0, 94, 185, 1), color(239, 48, 62, 1)], [list: 22, 16], [list: 6, 4]
  row: "finland", [list: white, color(24, 68, 126, 1)], [list: 18, 11], [list: 4, 3, 5]
  row: "island", [list: color(2, 82, 156, 1), white, color(220, 30, 53, 1)], [list: 25, 18], [list: 7, 4]
  end

  # Filtrerer rad for å hente data om korrekt nasjon.
  flagg-rad-filtrert = sieve flagg-tabell using nasjon:
    # gjør om argument tekst til små bokstaver.
    nasjon == string-to-lower(nordisk-nasjon)
  end

  if flagg-rad-filtrert.length() == 0:
    raise("Argumentet '" + nordisk-nasjon + "' stemmer ikke med en Nordisk nasjon!")
  else:
    flagg-rad = flagg-rad-filtrert.row-n(0)

    hoved-kors-bredde = flagg-rad["breddeforhold"].get(1)

    # Henter flaggdimensjoner fra tabell.
    flagg-lengde = flagg-rad["proposjoner"].get(0) * 10
    flagg-bredde = flagg-rad["proposjoner"].get(1) * 10

    hoved-kors = hoved-kors-bredde * 10
    andre-kors = (hoved-kors-bredde / 2) * 10
    hoved-plassering = flagg-rad["breddeforhold"].get(0) * -10

    # definer bakgrunn
    bakgrunn = rectangle(flagg-lengde, flagg-bredde, "solid", flagg-rad["farger"].get(0))

    # Definer hvite striper
    hoved-kors-linje-horisontalt = rectangle(flagg-lengde, hoved-kors, "solid", flagg-rad["farger"].get(1))
    hoved-kors-linje-vertikalt = rectangle(hoved-kors, flagg-bredde, "solid", flagg-rad["farger"].get(1))

    # tegn horisontal kors på bakrunn.
    hovedkors-overlay = overlay-xy(hoved-kors-linje-horisontalt, 0, hoved-plassering, bakgrunn)

    # Lambda for å plassere korset riktig til flaggets aktielle dimensjoner.
    konstruer-kors = lam():
      if flagg-rad["breddeforhold"].length() > 2:
        kors-avlangt-rektangel-plassering = flagg-rad["breddeforhold"].get(2) * -10
        overlay-xy(hoved-kors-linje-vertikalt, kors-avlangt-rektangel-plassering, 0, hovedkors-overlay)
      else:
        overlay-xy(hoved-kors-linje-vertikalt, hoved-plassering, 0, hovedkors-overlay)
      end
    end

    to-farget-flagg = konstruer-kors()

    # Hvis flagget har 3 farger, plasser det oppå. 
    if flagg-rad["farger"].length() > 2:
      andre-plassering = hoved-plassering + ((hoved-kors-bredde / 4) * -10)
      andre-kors-linje-horisontalt = rectangle(flagg-lengde, andre-kors, "solid", flagg-rad["farger"].get(2))
      andre-kors-linje-vertikalt = rectangle(andre-kors, flagg-bredde, "solid", flagg-rad["farger"].get(2))

      # Plasser blå striper på flagger.
      andre-kors-overlay = overlay-xy(andre-kors-linje-horisontalt, 0, andre-plassering, to-farget-flagg)
      tre-farget-flagg = overlay-xy(andre-kors-linje-vertikalt, andre-plassering, 0, andre-kors-overlay)

      # Returner resultat.
      tre-farget-flagg
    else:
      to-farget-flagg
    end
  end
end
lag-nordisk-flagg("norge")
lag-nordisk-flagg("danmark")
lag-nordisk-flagg("sverige")
