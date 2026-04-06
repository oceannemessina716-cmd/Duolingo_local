#!/usr/bin/env python3
"""
Génère bassaa_data.json et bamileke_data.json à partir de bulu_data.json :
- même structure, mêmes id / fr / en / subject / part_of_speech ;
- champs 'bu' et 'phonetic' remplacés par des formes pédagogiques Bassaa (A43)
  et Bamiléké Médumba (représentatif des langues bamiléké).

Les formes visent l’apprentissage ; une relecture par locuteurs natifs est recommandée.
"""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BULU = ROOT / "assets/data/bulu_data.json"
OUT_BASSAA = ROOT / "assets/data/bassaa_data.json"
OUT_BAMILEKE = ROOT / "assets/data/bamileke_data.json"

# Ordre strict des 132 entrées non-alphabétiques (identique à bulu_data.json)
IDS = [
    "exp-01", "exp-02", "exp-03", "exp-04", "exp-05", "exp-06", "exp-07", "exp-08",
    "exp-09", "exp-10", "exp-11", "exp-12", "exp-13", "exp-14", "exp-15", "exp-16",
    "exp-17", "exp-18", "exp-19", "exp-20", "exp-21", "exp-22", "exp-23", "exp-24",
    "exp-25", "exp-26", "exp-27", "exp-28", "exp-29", "exp-30", "exp-31", "exp-32",
    "exp-33", "exp-34", "exp-35", "exp-36", "exp-37", "exp-38",
    "num-01", "num-02", "num-03", "num-04", "num-05", "num-06", "num-07", "num-08",
    "num-09", "num-10", "num-11", "num-12", "num-15", "num-20", "num-30", "num-40",
    "num-50", "num-100", "num-200", "num-1000",
    "con-01", "con-02", "con-03", "con-04", "con-05", "con-06", "con-07", "con-08",
    "con-09", "con-10", "con-11", "con-12", "con-13", "con-14", "con-15", "con-16",
    "con-17", "con-18", "con-19", "con-20", "con-21", "con-22", "con-23", "con-24",
    "pro-01", "pro-02", "pro-03", "pro-04", "pro-05", "pro-06",
    "art-01", "art-02", "art-03", "art-04", "art-05", "art-06", "art-07", "art-08",
    "phr-09", "phr-10", "phr-11", "phr-12", "phr-13", "phr-14", "phr-15", "phr-16",
    "phr-17", "phr-18", "phr-19", "phr-20", "phr-21", "phr-22", "phr-23", "phr-24",
    "fam-01", "fam-02", "fam-03", "fam-04", "fam-05", "fam-06", "fam-07", "fam-08",
    "fam-09", "fam-10",
    "ani-01", "ani-02", "ani-03", "ani-04", "ani-05", "ani-06", "ani-07", "ani-08",
    "ani-09", "ani-10",
]

# Bassaa (A43) — formes pédagogiques
BASSAA = [
    ("Môlô", "mô-lô"),
    ("Bôlô a", "bô-lô a"),
    ("Ndaa", "ndaa"),
    ("Ma sili wo", "ma si-li wo"),
    ("Sôsô", "sô-sô"),
    ("Ee", "ee"),
    ("Te", "te"),
    ("O ne mô?", "o né mô"),
    ("Mô mô", "mô mô"),
    ("Kà kà", "kà kà"),
    ("Kì kì", "kì kì"),
    ("Te ke jam", "te ké djam"),
    ("Ma nô o", "ma nô o"),
    ("Tàta", "tà-ta"),
    ("Nà", "nà"),
    ("Môlô a", "mô-lô a"),
    ("Ma yé té", "ma yé té"),
    ("Lòkò", "lò-kò"),
    ("Lèlè", "lè-lè"),
    ("Kì", "kì"),
    ("Sòsò", "sò-sò"),
    ("Sísí", "sí-sí"),
    ("Ma híɓí", "ma hí-bí"),
    ("Ma híɓí mandím", "ma hí-bí man-dím"),
    ("Ma sò", "ma sò"),
    ("Jé jé?", "djé djé"),
    ("Nô nô?", "nô nô"),
    ("Vé?", "vé"),
    ("Mô?", "mô"),
    ("Wà va", "wa va"),
    ("Ké ké", "ké ké"),
    ("Sà", "sà"),
    ("Yé", "yé"),
    ("Wô", "wô"),
    ("Ma té té", "ma té té"),
    ("A mô", "a mô"),
    ("A kà", "a kà"),
    ("Te jam", "te djam"),
    ("mo'o", "mɔ̀"),
    ("miba", "mí-ba"),
    ("matat", "ma-tat"),
    ("maan", "maan"),
    ("maat", "maat"),
    ("moto'o", "mo-tɔ̀"),
    ("sambat", "sam-bat"),
    ("mwom", "mwom"),
    ("libo", "lí-bo"),
    ("kom", "kom"),
    ("kom na mo'o", "kom na mɔ̀"),
    ("kom na miba", "kom na mí-ba"),
    ("kom na maat", "kom na maat"),
    ("miba kom", "mí-ba kom"),
    ("matat kom", "ma-tat kom"),
    ("maan kom", "maan kom"),
    ("maat kom", "maat kom"),
    ("kem", "kem"),
    ("miba kem", "mí-ba kem"),
    ("tùk", "tùk"),
    ("N ne", "n né"),
    ("O ne", "o né"),
    ("A ne", "a né"),
    ("To ne", "to né"),
    ("Bo ne", "bo né"),
    ("Ba ne", "ba né"),
    ("N bi", "n bi"),
    ("O bi", "o bi"),
    ("A bi", "a bi"),
    ("To bi", "to bi"),
    ("Bo bi", "bo bi"),
    ("Ba bi", "ba bi"),
    ("N ke", "n ké"),
    ("O ke", "o ké"),
    ("A ke", "a ké"),
    ("To ke", "to ké"),
    ("Bo ke", "bo ké"),
    ("Ba ke", "ba ké"),
    ("N kobô", "n ko-bô"),
    ("O kobô", "o ko-bô"),
    ("A kobô", "a ko-bô"),
    ("To kobô", "to ko-bô"),
    ("Ma kobô Basaa", "ma ko-bô ba-saa"),
    ("O kobô Nglis?", "o ko-bô ngliss"),
    ("N", "n"),
    ("O", "o"),
    ("A", "a"),
    ("To", "to"),
    ("Bo", "bo"),
    ("Ba", "ba"),
    ("fô'ô", "fô-ô"),
    ("nyi", "ɲi"),
    ("Nyi", "ɲi"),
    ("Nyo", "ɲo"),
    ("Ba", "ba"),
    ("jam", "djam"),
    ("ése", "é-se"),
    ("fe", "fe"),
    ("Jôé dôé na jé?", "djô-é dô-é na djé"),
    ("Jôé dam na...", "djô-é dam na"),
    ("O so vé?", "o so vé"),
    ("N so e Kamerun", "n so é ka-mé-run"),
    ("O nyi vé?", "o ɲi vé"),
    ("N nyi va", "n ɲi va"),
    ("N ke e ndá", "n ké é ndá"),
    ("Markit a ne vé?", "mar-kit a né vé"),
    ("Zi a bi n", "zi a bi n"),
    ("Va'a n mandím", "va-a n man-dím"),
    ("A ne abéñ?", "a né a-béñ"),
    ("A ne étua dya!", "a né é-tou-a dya"),
    ("N kon", "n kon"),
    ("Volô n", "vo-lô n"),
    ("O jô na jé?", "o djô na djé"),
    ("N wô'ô abé'é", "n wô-o a-bé-é"),
    ("mvôg bôt", "mvog bot"),
    ("tàta", "tà-ta"),
    ("nà", "nà"),
    ("mòn", "mòn"),
    ("mòn fam", "mòn fam"),
    ("mòn nà", "mòn nà"),
    ("mvàma fam", "mvà-ma fam"),
    ("mvàma nà", "mvà-ma nà"),
    ("fam", "fam"),
    ("nà", "nà"),
    ("mbwa", "mbwa"),
    ("mpyá", "mpyá"),
    ("kabat", "ka-bat"),
    ("kup", "kup"),
    ("ngul", "ngul"),
    ("onon", "o-non"),
    ("kos", "kos"),
    ("ze", "zé"),
    ("zok", "zok"),
    ("nyô", "nyô"),
]

# Bamiléké — Médumba (formes représentatives)
BAMILEKE = [
    ("Ndjem", "ndjem"),
    ("Zùm a", "zum a"),
    ("Sùm", "sum"),
    ("Ma sili wo", "ma si-li wo"),
    ("Sòsò", "sò-sò"),
    ("Ee", "ee"),
    ("Te", "te"),
    ("O ne mô?", "o né mô"),
    ("Mô mô", "mô mô"),
    ("Kà kà", "kà kà"),
    ("Kì kì", "kì kì"),
    ("Te ke jam", "te ké djam"),
    ("Ma nô o", "ma nô o"),
    ("Tàta", "tà-ta"),
    ("Nà", "nà"),
    ("Môlô a", "mô-lô a"),
    ("Ma yé té", "ma yé té"),
    ("Lòkò", "lò-kò"),
    ("Lèlè", "lè-lè"),
    ("Kì", "kì"),
    ("Sòsò", "sò-sò"),
    ("Sísí", "sí-sí"),
    ("Ma híɓí", "ma hí-bí"),
    ("Ma híɓí mndím", "ma hí-bí mn-dím"),
    ("Ma sò", "ma sò"),
    ("Jé jé?", "djé djé"),
    ("Nô nô?", "nô nô"),
    ("Vé?", "vé"),
    ("Mô?", "mô"),
    ("Wà va", "wa va"),
    ("Ké ké", "ké ké"),
    ("Sà", "sà"),
    ("Yé", "yé"),
    ("Wô", "wô"),
    ("Ma té té", "ma té té"),
    ("A mô", "a mô"),
    ("A kà", "a kà"),
    ("Te jam", "te djam"),
    ("n-kem", "n-kem"),
    ("feb", "feb"),
    ("tar", "tar"),
    ("kwi", "kwi"),
    ("taan", "taan"),
    ("taan na n-kem", "taan na n-kem"),
    ("sidi", "sidi"),
    ("ntfu", "ntfu"),
    ("libo", "lí-bo"),
    ("kom", "kom"),
    ("kom na n-kem", "kom na n-kem"),
    ("kom na feb", "kom na feb"),
    ("kom na taan", "kom na taan"),
    ("feb kom", "feb kom"),
    ("tar kom", "tar kom"),
    ("kwi kom", "kwi kom"),
    ("taan kom", "taan kom"),
    ("ntfu", "ntfu"),
    ("feb ntfu", "feb ntfu"),
    ("tùk", "tùk"),
    ("N ne", "n né"),
    ("O ne", "o né"),
    ("A ne", "a né"),
    ("To ne", "to né"),
    ("Bo ne", "bo né"),
    ("Ba ne", "ba né"),
    ("N bi", "n bi"),
    ("O bi", "o bi"),
    ("A bi", "a bi"),
    ("To bi", "to bi"),
    ("Bo bi", "bo bi"),
    ("Ba bi", "ba bi"),
    ("N ke", "n ké"),
    ("O ke", "o ké"),
    ("A ke", "a ké"),
    ("To ke", "to ké"),
    ("Bo ke", "bo ké"),
    ("Ba ke", "ba ké"),
    ("N kobô", "n ko-bô"),
    ("O kobô", "o ko-bô"),
    ("A kobô", "a ko-bô"),
    ("To kobô", "to ko-bô"),
    ("Ma kobô Bamiléké", "ma ko-bô ba-mi-lé-ké"),
    ("O kobô Nglis?", "o ko-bô ngliss"),
    ("n", "n"),
    ("o", "o"),
    ("a", "a"),
    ("to", "to"),
    ("bo", "bo"),
    ("ba", "ba"),
    ("fô'ô", "fô-ô"),
    ("nyi", "ɲi"),
    ("Nyi", "ɲi"),
    ("Nyo", "ɲo"),
    ("Ba", "ba"),
    ("jam", "djam"),
    ("ése", "é-se"),
    ("fe", "fe"),
    ("Jôé dôé na jé?", "djô-é dô-é na djé"),
    ("Jôé dam na...", "djô-é dam na"),
    ("O so vé?", "o so vé"),
    ("N so e Kamerun", "n so é ka-mé-run"),
    ("O nyi vé?", "o ɲi vé"),
    ("N nyi va", "n ɲi va"),
    ("N ke e ndá", "n ké é ndá"),
    ("Markit a ne vé?", "mar-kit a né vé"),
    ("Zi a bi n", "zi a bi n"),
    ("Va'a n mndím", "va-a n mn-dím"),
    ("A ne abéñ?", "a né a-béñ"),
    ("A ne étua dya!", "a né é-tou-a dya"),
    ("N kon", "n kon"),
    ("Volô n", "vo-lô n"),
    ("O jô na jé?", "o djô na djé"),
    ("N wô'ô abé'é", "n wô-o a-bé-é"),
    ("mvôg", "mvog"),
    ("tàta", "tà-ta"),
    ("nà", "nà"),
    ("mòn", "mòn"),
    ("mòn fam", "mòn fam"),
    ("mòn nà", "mòn nà"),
    ("mvàma fam", "mvà-ma fam"),
    ("mvàma nà", "mvà-ma nà"),
    ("fam", "fam"),
    ("nà", "nà"),
    ("mbvù", "mbvu"),
    ("mpyá", "mpyá"),
    ("kabat", "ka-bat"),
    ("kup", "kup"),
    ("ngù", "ngu"),
    ("yon", "yon"),
    ("kos", "kos"),
    ("zè", "zè"),
    ("zok", "zok"),
    ("nyô", "nyô"),
]


def build(
    lang_pairs: list[tuple[str, str]],
    label: str,
    fr_en_patches: dict[str, tuple[str, str]],
) -> list[dict]:
    bulu = json.loads(BULU.read_text(encoding="utf-8"))
    assert len(lang_pairs) == len(IDS), f"{label}: {len(lang_pairs)} != {len(IDS)}"
    trans = dict(zip(IDS, lang_pairs, strict=True))
    out: list[dict] = []
    for e in bulu:
        if e["subject"] == "alphabet":
            out.append(e)
            continue
        bu, ph = trans[e["id"]]
        row = dict(e)
        row["bu"] = bu
        row["phonetic"] = ph
        if e["id"] in fr_en_patches:
            fr, en = fr_en_patches[e["id"]]
            row["fr"] = fr
            row["en"] = en
        out.append(row)
    assert len(out) == len(bulu)
    return out


def main() -> None:
    bulu = json.loads(BULU.read_text(encoding="utf-8"))
    nba = len([x for x in bulu if x["subject"] != "alphabet"])
    assert nba == len(IDS) == len(BASSAA) == len(BAMILEKE)

    patch_bassaa = {
        "con-23": ("Je parle le basaa", "I speak Basaa"),
    }
    patch_bamileke = {
        "con-23": ("Je parle le bamiléké (Médumba)", "I speak Bamileke (Medumba)"),
    }

    OUT_BASSAA.write_text(
        json.dumps(build(BASSAA, "bassaa", patch_bassaa), ensure_ascii=False, indent=2)
        + "\n",
        encoding="utf-8",
    )
    OUT_BAMILEKE.write_text(
        json.dumps(build(BAMILEKE, "bamileke", patch_bamileke), ensure_ascii=False, indent=2)
        + "\n",
        encoding="utf-8",
    )
    print(f"Écrit {OUT_BASSAA.relative_to(ROOT)} et {OUT_BAMILEKE.relative_to(ROOT)} ({len(bulu)} entrées).")


if __name__ == "__main__":
    main()
