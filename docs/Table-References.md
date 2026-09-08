# BIA References Logic Documentation

## 1. Example payload

```json
{
  "process_id": "6c23a670d3164c2f902059237dc2104e",
  "status": "succeed",
  "error": null,
  "duration_seconds": 3.08,
  "webhook_url": "https://discord.com/api/webhooks/...",
  "metadata": null,
  "sex": "male",
  "age": 30,
  "weight_kg": 90.0,
  "height_cm": 180.0,
  "bia": 16.61,
  "dxa": 17.57,
  "biceps": 37.09,
  "forearm": 30.3,
  "waist": 84.96,
  "hip": 101.95,
  "thigh": 57.66,
  "calf": 39.13,
  "waist_height": 0.47,
  "waist_hip": 0.83,
  "ic_index": 1.1,
  "fat_mass_bia": 14.95,
  "fat_mass_index_bia": 4.61,
  "lean_mass_bia": 75.05,
  "lean_mass_index_bia": 23.16,
  "water_bia": 54.79,
  "tmb_bia": 2151.1
}
```

Relevant fields:

| Payload field | Role |
|---|---|
| `sex` | Must be normalized to `"F"`/`"M"`. Defines the branch of each table. |
| `age` | Used directly as `age`. |

All other fields (`process_id`, `status`, `error`, `duration_seconds`,
`webhook_url`, `metadata`, `weight_kg`, `height_cm`, `biceps`, `forearm`,
`waist`, `hip`, `thigh`, `calf`, `waist_height`, `waist_hip`, `ic_index`,
`bia`, `dxa`, `fat_mass_bia`, `fat_mass_index_bia`, `lean_mass_bia`,
`lean_mass_index_bia`, `water_bia`, `tmb_bia`) **are not used** to build the
ranges. They are the measured values that would later be compared against
the generated ranges.

## 2. Output structure

The output always has the same 8 keys, each holding a dictionary of ranges
`{"min": ..., "max": ...}`:

```
{
  "fat_percentage_references": {...},
  "fat_mass_index_references": {...},
  "lean_mass_index_references": {...},
  "waist_references": {...},
  "hip_references": {...},
  "waist_hip_references": {...},
  "cardiovascular_risk_references": {...},
  "ic_index_references": {...}
}
```

## 3. BIA rule tables

### 3.1 **`fat_percentage_references`** (by sex + age range):

| Sex | Age | attention | low_risk | moderate | high_risk |
|---|---|---|---|---|---|
| F | ≤24 | 12–19 | 19–26.3 | 26.3–29.7 | 29.7–40 |
| F | 24–34 | 11–17.7 | 17.7–26.5 | 26.5–29.8 | 29.8–40 |
| F | 34–44 | 11–17.8 | 17.8–26.4 | 26.4–29.9 | 29.9–40 |
| F | 44–54 | 11–18 | 18–27.9 | 27.9–32 | 32–40 |
| F | >54 | 14–21.4 | 21.4–32.5 | 32.5–36 | 36–44 |
| M | ≤24 | 4–9.3 | 9.3–16 | 16–18.7 | 18.7–28 |
| M | 24–34 | 5–11 | 11–18.2 | 18.2–21.9 | 21.9–31 |
| M | 34–44 | 5–11 | 11–19.5 | 19.5–23.2 | 23.2–32 |
| M | 44–54 | 5–11.8 | 11.8–20.3 | 20.3–23.8 | 23.8–32 |
| M | >54 | 6–12 | 12–22.8 | 22.8–26.4 | 26.4–34 |

### 3.2 **`fat_mass_index_references`** (by sex + age range):

| Sex | Age | low | appropriate | high |
|---|---|---|---|---|
| F | ≤34 | 1.1–3.5 | 3.5–5.9 | 5.9–8.3 |
| F | 34–54 | 0.3–3.4 | 3.4–6.5 | 6.5–9.6 |
| F | >54 | 0–4.5 | 4.5–9 | 9–13.5 |
| M | ≤34 | 0–2.2 | 2.2–4.4 | 4.4–6.6 |
| M | 34–54 | 0–2.5 | 2.5–5 | 5–7.5 |
| M | >54 | 0–2.8 | 2.8–5.7 | 5.7–8.6 |

### 3.3 **`lean_mass_index_references`** (by sex + age range):

| Sex | Age | low | appropriate | high |
|---|---|---|---|---|
| F | ≤29 | 11–14 | 14–17 | 17–20 |
| F | 29–39 | 10.6–14.1 | 14.1–17.6 | 17.6–21.1 |
| F | 39–49 | 10.3–13.8 | 13.8–17.3 | 17.3–20.8 |
| F | 49–59 | 10.5–13.9 | 13.9–17.3 | 17.3–20.7 |
| F | >59 | 10.8–13.9 | 13.9–17 | 17–20.1 |
| M | ≤29 | 13.3–17.8 | 17.8–22.3 | 22.3–26.8 |
| M | 29–39 | 13.6–17.4 | 17.4–21.2 | 21.2–25 |
| M | 39–49 | 13.8–17.4 | 17.4–21 | 21–24.6 |
| M | 49–59 | 13.6–17.2 | 17.2–20.8 | 20.8–24.4 |
| M | >59 | 14.2–17.3 | 17.3–20.4 | 20.4–23.5 |

### 3.4 **`waist_references`** (by sex):

| Sex | low_risk | moderate | high_risk |
|---|---|---|---|
| F | 66–80 | 80–88 | 88–104 |
| M | 70–94 | 94–102 | 102–118 |

### 3.5 **`hip_references`** (by sex):

| Sex | attention | low_risk | moderate | high_risk |
|---|---|---|---|---|
| F | 92.5–97.6 | 97.6–107.7 | 107.7–112.8 | 112.8–123 |
| M | 93.3–97.2 | 97.2–104.8 | 104.8–108.6 | 108.6–116.2 |

### 3.6 **`cardiovascular_risk_references`** (Fixed, does not depend on sex/age):

| low_risk | moderate | high_risk |
|---|---|---|
| 0.4–0.5 | 0.5–0.55 | 0.55–0.7 |

### 3.7 **`waist_hip_references`** (by sex):

| Sex | adequate | inappropriate |
|---|---|---|
| F | 0.65–0.85 | 0.85–1 |
| M | 0.7–0.9 | 0.9–1.15 |

### 3.8 **`ic_index_references`** (by sex):

| Sex | adequate | inappropriate |
|---|---|---|
| F | 0.7–1.18 | 1.18–1.4 |
| M | 0.7–1.25 | 1.25–1.4 |

## 4. Reference implementations

### 4.1 Python

```python
from typing import Literal, TypedDict


class Band(TypedDict):
    min: float
    max: float


Sex = Literal["F", "M"]


def get_tables_references(sex: Sex, age: int) -> dict:
    return {
        "fat_percentage_references": _fat_percentage_bia_references(sex, age),
        "fat_mass_index_references": _fat_mass_index_bia_references(sex, age),
        "lean_mass_index_references": _lean_mass_index_bia_references(sex, age),
        "waist_references": _waist_references(sex),
        "hip_references": _hip_references(sex),
        "waist_hip_references": _waist_hip_references(sex),
        "cardiovascular_risk_references": _cardiovascular_risk_references(),
        "ic_index_references": _ic_index_references(sex),
    }


def _fat_percentage_bia_references(sex: Sex, age: int) -> dict:
    if sex == "F":
        if age <= 24:
            return {"attention": {"min": 12, "max": 19}, "low_risk": {"min": 19, "max": 26.3},
                    "moderate": {"min": 26.3, "max": 29.7}, "high_risk": {"min": 29.7, "max": 40}}
        elif age <= 34:
            return {"attention": {"min": 11, "max": 17.7}, "low_risk": {"min": 17.7, "max": 26.5},
                    "moderate": {"min": 26.5, "max": 29.8}, "high_risk": {"min": 29.8, "max": 40}}
        elif age <= 44:
            return {"attention": {"min": 11, "max": 17.8}, "low_risk": {"min": 17.8, "max": 26.4},
                    "moderate": {"min": 26.4, "max": 29.9}, "high_risk": {"min": 29.9, "max": 40}}
        elif age <= 54:
            return {"attention": {"min": 11, "max": 18}, "low_risk": {"min": 18, "max": 27.9},
                    "moderate": {"min": 27.9, "max": 32}, "high_risk": {"min": 32, "max": 40}}
        else:
            return {"attention": {"min": 14, "max": 21.4}, "low_risk": {"min": 21.4, "max": 32.5},
                    "moderate": {"min": 32.5, "max": 36}, "high_risk": {"min": 36, "max": 44}}
    else:
        if age <= 24:
            return {"attention": {"min": 4, "max": 9.3}, "low_risk": {"min": 9.3, "max": 16},
                    "moderate": {"min": 16, "max": 18.7}, "high_risk": {"min": 18.7, "max": 28}}
        elif age <= 34:
            return {"attention": {"min": 5, "max": 11}, "low_risk": {"min": 11, "max": 18.2},
                    "moderate": {"min": 18.2, "max": 21.9}, "high_risk": {"min": 21.9, "max": 31}}
        elif age <= 44:
            return {"attention": {"min": 5, "max": 11}, "low_risk": {"min": 11, "max": 19.5},
                    "moderate": {"min": 19.5, "max": 23.2}, "high_risk": {"min": 23.2, "max": 32}}
        elif age <= 54:
            return {"attention": {"min": 5, "max": 11.8}, "low_risk": {"min": 11.8, "max": 20.3},
                    "moderate": {"min": 20.3, "max": 23.8}, "high_risk": {"min": 23.8, "max": 32}}
        else:
            return {"attention": {"min": 6, "max": 12}, "low_risk": {"min": 12, "max": 22.8},
                    "moderate": {"min": 22.8, "max": 26.4}, "high_risk": {"min": 26.4, "max": 34}}


def _fat_mass_index_bia_references(sex: Sex, age: int) -> dict:
    if sex == "F":
        if age <= 34:
            return {"low": {"min": 1.1, "max": 3.5}, "appropriate": {"min": 3.5, "max": 5.9}, "high": {"min": 5.9, "max": 8.3}}
        elif age <= 54:
            return {"low": {"min": 0.3, "max": 3.4}, "appropriate": {"min": 3.4, "max": 6.5}, "high": {"min": 6.5, "max": 9.6}}
        else:
            return {"low": {"min": 0, "max": 4.5}, "appropriate": {"min": 4.5, "max": 9}, "high": {"min": 9, "max": 13.5}}
    else:
        if age <= 34:
            return {"low": {"min": 0, "max": 2.2}, "appropriate": {"min": 2.2, "max": 4.4}, "high": {"min": 4.4, "max": 6.6}}
        elif age <= 54:
            return {"low": {"min": 0, "max": 2.5}, "appropriate": {"min": 2.5, "max": 5}, "high": {"min": 5, "max": 7.5}}
        else:
            return {"low": {"min": 0, "max": 2.8}, "appropriate": {"min": 2.8, "max": 5.7}, "high": {"min": 5.7, "max": 8.6}}


def _lean_mass_index_bia_references(sex: Sex, age: int) -> dict:
    f = sex == "F"
    if age <= 29:
        return {"low": {"min": 11 if f else 13.3, "max": 14 if f else 17.8},
                "appropriate": {"min": 14 if f else 17.8, "max": 17 if f else 22.3},
                "high": {"min": 17 if f else 22.3, "max": 20 if f else 26.8}}
    elif age <= 39:
        return {"low": {"min": 10.6 if f else 13.6, "max": 14.1 if f else 17.4},
                "appropriate": {"min": 14.1 if f else 17.4, "max": 17.6 if f else 21.2},
                "high": {"min": 17.6 if f else 21.2, "max": 21.1 if f else 25}}
    elif age <= 49:
        return {"low": {"min": 10.3 if f else 13.8, "max": 13.8 if f else 17.4},
                "appropriate": {"min": 13.8 if f else 17.4, "max": 17.3 if f else 21},
                "high": {"min": 17.3 if f else 21, "max": 20.8 if f else 24.6}}
    elif age <= 59:
        return {"low": {"min": 10.5 if f else 13.6, "max": 13.9 if f else 17.2},
                "appropriate": {"min": 13.9 if f else 17.2, "max": 17.3 if f else 20.8},
                "high": {"min": 17.3 if f else 20.8, "max": 20.7 if f else 24.4}}
    else:
        return {"low": {"min": 10.8 if f else 14.2, "max": 13.9 if f else 17.3},
                "appropriate": {"min": 13.9 if f else 17.3, "max": 17 if f else 20.4},
                "high": {"min": 17 if f else 20.4, "max": 20.1 if f else 23.5}}


def _waist_references(sex: Sex) -> dict:
    if sex == "F":
        return {"low_risk": {"min": 66, "max": 80}, "moderate": {"min": 80, "max": 88}, "high_risk": {"min": 88, "max": 104}}
    return {"low_risk": {"min": 70, "max": 94}, "moderate": {"min": 94, "max": 102}, "high_risk": {"min": 102, "max": 118}}


def _hip_references(sex: Sex) -> dict:
    if sex == "F":
        return {"attention": {"min": 92.5, "max": 97.6}, "low_risk": {"min": 97.6, "max": 107.7},
                "moderate": {"min": 107.7, "max": 112.8}, "high_risk": {"min": 112.8, "max": 123}}
    return {"attention": {"min": 93.3, "max": 97.2}, "low_risk": {"min": 97.2, "max": 104.8},
            "moderate": {"min": 104.8, "max": 108.6}, "high_risk": {"min": 108.6, "max": 116.2}}


def _cardiovascular_risk_references() -> dict:
    return {"low_risk": {"min": 0.4, "max": 0.5}, "moderate": {"min": 0.5, "max": 0.55}, "high_risk": {"min": 0.55, "max": 0.7}}


def _waist_hip_references(sex: Sex) -> dict:
    if sex == "F":
        return {"adequate": {"min": 0.65, "max": 0.85}, "inappropriate": {"min": 0.85, "max": 1}}
    return {"adequate": {"min": 0.7, "max": 0.9}, "inappropriate": {"min": 0.9, "max": 1.15}}


def _ic_index_references(sex: Sex) -> dict:
    if sex == "F":
        return {"adequate": {"min": 0.7, "max": 1.18}, "inappropriate": {"min": 1.18, "max": 1.4}}
    return {"adequate": {"min": 0.7, "max": 1.25}, "inappropriate": {"min": 1.25, "max": 1.4}}


# ---------- Example usage with the provided payload ----------

def normalize_sex(raw_sex: str) -> Sex:
    return "F" if raw_sex.strip().lower().startswith("f") else "M"


if __name__ == "__main__":
    payload = {
        "sex": "male", "age": 30, "fat_mass_index_bia": 4.61, "lean_mass_index_bia": 23.16,
        "waist": 84.96, "hip": 101.95, "waist_hip": 0.83, "ic_index": 1.1,
        "fat_mass_bia": 14.95, "lean_mass_bia": 75.05, "water_bia": 54.79, "tmb_bia": 2151.1,
    }
    sex = normalize_sex(payload["sex"])
    print(get_tables_references(sex, payload["age"]))
```

### 4.2 TypeScript

```typescript
type Band = { min: number; max: number };
type Sex = "F" | "M";

interface TablesReferences {
  fat_percentage_references: Record<string, Band>;
  fat_mass_index_references: Record<string, Band>;
  lean_mass_index_references: Record<string, Band>;
  waist_references: Record<string, Band>;
  hip_references: Record<string, Band>;
  waist_hip_references: Record<string, Band>;
  cardiovascular_risk_references: Record<string, Band>;
  ic_index_references: Record<string, Band>;
}

export function getTablesReferences(sex: Sex, age: number): TablesReferences {
  return {
    fat_percentage_references: fatPercentageBiaReferences(sex, age),
    fat_mass_index_references: fatMassIndexBiaReferences(sex, age),
    lean_mass_index_references: leanMassIndexBiaReferences(sex, age),
    waist_references: waistReferences(sex),
    hip_references: hipReferences(sex),
    waist_hip_references: waistHipReferences(sex),
    cardiovascular_risk_references: cardiovascularRiskReferences(),
    ic_index_references: icIndexReferences(sex),
  };
}

function fatPercentageBiaReferences(sex: Sex, age: number): Record<string, Band> {
  if (sex === "F") {
    if (age <= 24) return { attention: { min: 12, max: 19 }, low_risk: { min: 19, max: 26.3 }, moderate: { min: 26.3, max: 29.7 }, high_risk: { min: 29.7, max: 40 } };
    if (age <= 34) return { attention: { min: 11, max: 17.7 }, low_risk: { min: 17.7, max: 26.5 }, moderate: { min: 26.5, max: 29.8 }, high_risk: { min: 29.8, max: 40 } };
    if (age <= 44) return { attention: { min: 11, max: 17.8 }, low_risk: { min: 17.8, max: 26.4 }, moderate: { min: 26.4, max: 29.9 }, high_risk: { min: 29.9, max: 40 } };
    if (age <= 54) return { attention: { min: 11, max: 18 }, low_risk: { min: 18, max: 27.9 }, moderate: { min: 27.9, max: 32 }, high_risk: { min: 32, max: 40 } };
    return { attention: { min: 14, max: 21.4 }, low_risk: { min: 21.4, max: 32.5 }, moderate: { min: 32.5, max: 36 }, high_risk: { min: 36, max: 44 } };
  }
  if (age <= 24) return { attention: { min: 4, max: 9.3 }, low_risk: { min: 9.3, max: 16 }, moderate: { min: 16, max: 18.7 }, high_risk: { min: 18.7, max: 28 } };
  if (age <= 34) return { attention: { min: 5, max: 11 }, low_risk: { min: 11, max: 18.2 }, moderate: { min: 18.2, max: 21.9 }, high_risk: { min: 21.9, max: 31 } };
  if (age <= 44) return { attention: { min: 5, max: 11 }, low_risk: { min: 11, max: 19.5 }, moderate: { min: 19.5, max: 23.2 }, high_risk: { min: 23.2, max: 32 } };
  if (age <= 54) return { attention: { min: 5, max: 11.8 }, low_risk: { min: 11.8, max: 20.3 }, moderate: { min: 20.3, max: 23.8 }, high_risk: { min: 23.8, max: 32 } };
  return { attention: { min: 6, max: 12 }, low_risk: { min: 12, max: 22.8 }, moderate: { min: 22.8, max: 26.4 }, high_risk: { min: 26.4, max: 34 } };
}

function fatMassIndexBiaReferences(sex: Sex, age: number): Record<string, Band> {
  if (sex === "F") {
    if (age <= 34) return { low: { min: 1.1, max: 3.5 }, appropriate: { min: 3.5, max: 5.9 }, high: { min: 5.9, max: 8.3 } };
    if (age <= 54) return { low: { min: 0.3, max: 3.4 }, appropriate: { min: 3.4, max: 6.5 }, high: { min: 6.5, max: 9.6 } };
    return { low: { min: 0, max: 4.5 }, appropriate: { min: 4.5, max: 9 }, high: { min: 9, max: 13.5 } };
  }
  if (age <= 34) return { low: { min: 0, max: 2.2 }, appropriate: { min: 2.2, max: 4.4 }, high: { min: 4.4, max: 6.6 } };
  if (age <= 54) return { low: { min: 0, max: 2.5 }, appropriate: { min: 2.5, max: 5 }, high: { min: 5, max: 7.5 } };
  return { low: { min: 0, max: 2.8 }, appropriate: { min: 2.8, max: 5.7 }, high: { min: 5.7, max: 8.6 } };
}

function leanMassIndexBiaReferences(sex: Sex, age: number): Record<string, Band> {
  const f = sex === "F";
  if (age <= 29) return { low: { min: f ? 11 : 13.3, max: f ? 14 : 17.8 }, appropriate: { min: f ? 14 : 17.8, max: f ? 17 : 22.3 }, high: { min: f ? 17 : 22.3, max: f ? 20 : 26.8 } };
  if (age <= 39) return { low: { min: f ? 10.6 : 13.6, max: f ? 14.1 : 17.4 }, appropriate: { min: f ? 14.1 : 17.4, max: f ? 17.6 : 21.2 }, high: { min: f ? 17.6 : 21.2, max: f ? 21.1 : 25 } };
  if (age <= 49) return { low: { min: f ? 10.3 : 13.8, max: f ? 13.8 : 17.4 }, appropriate: { min: f ? 13.8 : 17.4, max: f ? 17.3 : 21 }, high: { min: f ? 17.3 : 21, max: f ? 20.8 : 24.6 } };
  if (age <= 59) return { low: { min: f ? 10.5 : 13.6, max: f ? 13.9 : 17.2 }, appropriate: { min: f ? 13.9 : 17.2, max: f ? 17.3 : 20.8 }, high: { min: f ? 17.3 : 20.8, max: f ? 20.7 : 24.4 } };
  return { low: { min: f ? 10.8 : 14.2, max: f ? 13.9 : 17.3 }, appropriate: { min: f ? 13.9 : 17.3, max: f ? 17 : 20.4 }, high: { min: f ? 17 : 20.4, max: f ? 20.1 : 23.5 } };
}

function waistReferences(sex: Sex): Record<string, Band> {
  if (sex === "F") return { low_risk: { min: 66, max: 80 }, moderate: { min: 80, max: 88 }, high_risk: { min: 88, max: 104 } };
  return { low_risk: { min: 70, max: 94 }, moderate: { min: 94, max: 102 }, high_risk: { min: 102, max: 118 } };
}

function hipReferences(sex: Sex): Record<string, Band> {
  if (sex === "F") return { attention: { min: 92.5, max: 97.6 }, low_risk: { min: 97.6, max: 107.7 }, moderate: { min: 107.7, max: 112.8 }, high_risk: { min: 112.8, max: 123 } };
  return { attention: { min: 93.3, max: 97.2 }, low_risk: { min: 97.2, max: 104.8 }, moderate: { min: 104.8, max: 108.6 }, high_risk: { min: 108.6, max: 116.2 } };
}

function cardiovascularRiskReferences(): Record<string, Band> {
  return { low_risk: { min: 0.4, max: 0.5 }, moderate: { min: 0.5, max: 0.55 }, high_risk: { min: 0.55, max: 0.7 } };
}

function waistHipReferences(sex: Sex): Record<string, Band> {
  if (sex === "F") return { adequate: { min: 0.65, max: 0.85 }, inappropriate: { min: 0.85, max: 1 } };
  return { adequate: { min: 0.7, max: 0.9 }, inappropriate: { min: 0.9, max: 1.15 } };
}

function icIndexReferences(sex: Sex): Record<string, Band> {
  if (sex === "F") return { adequate: { min: 0.7, max: 1.18 }, inappropriate: { min: 1.18, max: 1.4 } };
  return { adequate: { min: 0.7, max: 1.25 }, inappropriate: { min: 1.25, max: 1.4 } };
}

// ---------- Example usage with the provided payload ----------

interface AiPayload {
  sex: string;
  age: number;
}

function normalizeSex(rawSex: string): Sex {
  return rawSex.trim().toLowerCase().startsWith("f") ? "F" : "M";
}

const payload: AiPayload = { sex: "male", age: 30 };

const references = getTablesReferences(normalizeSex(payload.sex), payload.age);
console.log(references);
```

### 4.3 JavaScript (Node / browser)

```javascript
function getTablesReferences(sex, age) {
  return {
    fat_percentage_references: fatPercentageBiaReferences(sex, age),
    fat_mass_index_references: fatMassIndexBiaReferences(sex, age),
    lean_mass_index_references: leanMassIndexBiaReferences(sex, age),
    waist_references: waistReferences(sex),
    hip_references: hipReferences(sex),
    waist_hip_references: waistHipReferences(sex),
    cardiovascular_risk_references: cardiovascularRiskReferences(),
    ic_index_references: icIndexReferences(sex),
  };
}

function fatPercentageBiaReferences(sex, age) {
  if (sex === "F") {
    if (age <= 24) return { attention: { min: 12, max: 19 }, low_risk: { min: 19, max: 26.3 }, moderate: { min: 26.3, max: 29.7 }, high_risk: { min: 29.7, max: 40 } };
    if (age <= 34) return { attention: { min: 11, max: 17.7 }, low_risk: { min: 17.7, max: 26.5 }, moderate: { min: 26.5, max: 29.8 }, high_risk: { min: 29.8, max: 40 } };
    if (age <= 44) return { attention: { min: 11, max: 17.8 }, low_risk: { min: 17.8, max: 26.4 }, moderate: { min: 26.4, max: 29.9 }, high_risk: { min: 29.9, max: 40 } };
    if (age <= 54) return { attention: { min: 11, max: 18 }, low_risk: { min: 18, max: 27.9 }, moderate: { min: 27.9, max: 32 }, high_risk: { min: 32, max: 40 } };
    return { attention: { min: 14, max: 21.4 }, low_risk: { min: 21.4, max: 32.5 }, moderate: { min: 32.5, max: 36 }, high_risk: { min: 36, max: 44 } };
  }
  if (age <= 24) return { attention: { min: 4, max: 9.3 }, low_risk: { min: 9.3, max: 16 }, moderate: { min: 16, max: 18.7 }, high_risk: { min: 18.7, max: 28 } };
  if (age <= 34) return { attention: { min: 5, max: 11 }, low_risk: { min: 11, max: 18.2 }, moderate: { min: 18.2, max: 21.9 }, high_risk: { min: 21.9, max: 31 } };
  if (age <= 44) return { attention: { min: 5, max: 11 }, low_risk: { min: 11, max: 19.5 }, moderate: { min: 19.5, max: 23.2 }, high_risk: { min: 23.2, max: 32 } };
  if (age <= 54) return { attention: { min: 5, max: 11.8 }, low_risk: { min: 11.8, max: 20.3 }, moderate: { min: 20.3, max: 23.8 }, high_risk: { min: 23.8, max: 32 } };
  return { attention: { min: 6, max: 12 }, low_risk: { min: 12, max: 22.8 }, moderate: { min: 22.8, max: 26.4 }, high_risk: { min: 26.4, max: 34 } };
}

function fatMassIndexBiaReferences(sex, age) {
  if (sex === "F") {
    if (age <= 34) return { low: { min: 1.1, max: 3.5 }, appropriate: { min: 3.5, max: 5.9 }, high: { min: 5.9, max: 8.3 } };
    if (age <= 54) return { low: { min: 0.3, max: 3.4 }, appropriate: { min: 3.4, max: 6.5 }, high: { min: 6.5, max: 9.6 } };
    return { low: { min: 0, max: 4.5 }, appropriate: { min: 4.5, max: 9 }, high: { min: 9, max: 13.5 } };
  }
  if (age <= 34) return { low: { min: 0, max: 2.2 }, appropriate: { min: 2.2, max: 4.4 }, high: { min: 4.4, max: 6.6 } };
  if (age <= 54) return { low: { min: 0, max: 2.5 }, appropriate: { min: 2.5, max: 5 }, high: { min: 5, max: 7.5 } };
  return { low: { min: 0, max: 2.8 }, appropriate: { min: 2.8, max: 5.7 }, high: { min: 5.7, max: 8.6 } };
}

function leanMassIndexBiaReferences(sex, age) {
  const f = sex === "F";
  if (age <= 29) return { low: { min: f ? 11 : 13.3, max: f ? 14 : 17.8 }, appropriate: { min: f ? 14 : 17.8, max: f ? 17 : 22.3 }, high: { min: f ? 17 : 22.3, max: f ? 20 : 26.8 } };
  if (age <= 39) return { low: { min: f ? 10.6 : 13.6, max: f ? 14.1 : 17.4 }, appropriate: { min: f ? 14.1 : 17.4, max: f ? 17.6 : 21.2 }, high: { min: f ? 17.6 : 21.2, max: f ? 21.1 : 25 } };
  if (age <= 49) return { low: { min: f ? 10.3 : 13.8, max: f ? 13.8 : 17.4 }, appropriate: { min: f ? 13.8 : 17.4, max: f ? 17.3 : 21 }, high: { min: f ? 17.3 : 21, max: f ? 20.8 : 24.6 } };
  if (age <= 59) return { low: { min: f ? 10.5 : 13.6, max: f ? 13.9 : 17.2 }, appropriate: { min: f ? 13.9 : 17.2, max: f ? 17.3 : 20.8 }, high: { min: f ? 17.3 : 20.8, max: f ? 20.7 : 24.4 } };
  return { low: { min: f ? 10.8 : 14.2, max: f ? 13.9 : 17.3 }, appropriate: { min: f ? 13.9 : 17.3, max: f ? 17 : 20.4 }, high: { min: f ? 17 : 20.4, max: f ? 20.1 : 23.5 } };
}

function waistReferences(sex) {
  if (sex === "F") return { low_risk: { min: 66, max: 80 }, moderate: { min: 80, max: 88 }, high_risk: { min: 88, max: 104 } };
  return { low_risk: { min: 70, max: 94 }, moderate: { min: 94, max: 102 }, high_risk: { min: 102, max: 118 } };
}

function hipReferences(sex) {
  if (sex === "F") return { attention: { min: 92.5, max: 97.6 }, low_risk: { min: 97.6, max: 107.7 }, moderate: { min: 107.7, max: 112.8 }, high_risk: { min: 112.8, max: 123 } };
  return { attention: { min: 93.3, max: 97.2 }, low_risk: { min: 97.2, max: 104.8 }, moderate: { min: 104.8, max: 108.6 }, high_risk: { min: 108.6, max: 116.2 } };
}

function cardiovascularRiskReferences() {
  return { low_risk: { min: 0.4, max: 0.5 }, moderate: { min: 0.5, max: 0.55 }, high_risk: { min: 0.55, max: 0.7 } };
}

function waistHipReferences(sex) {
  if (sex === "F") return { adequate: { min: 0.65, max: 0.85 }, inappropriate: { min: 0.85, max: 1 } };
  return { adequate: { min: 0.7, max: 0.9 }, inappropriate: { min: 0.9, max: 1.15 } };
}

function icIndexReferences(sex) {
  if (sex === "F") return { adequate: { min: 0.7, max: 1.18 }, inappropriate: { min: 1.18, max: 1.4 } };
  return { adequate: { min: 0.7, max: 1.25 }, inappropriate: { min: 1.25, max: 1.4 } };
}

// ---------- Example usage with the provided payload ----------

function normalizeSex(rawSex) {
  return rawSex.trim().toLowerCase().startsWith("f") ? "F" : "M";
}

const payload = { sex: "male", age: 30 };

const references = getTablesReferences(normalizeSex(payload.sex), payload.age);
console.log(references);
```

## 5. Expected output for the example payload

With `sex = "male"` → `"M"` and `age = 30`, the output of the three
implementations above is:

```json
{
  "fat_percentage_references": {
    "attention": { "min": 5, "max": 11 },
    "low_risk": { "min": 11, "max": 18.2 },
    "moderate": { "min": 18.2, "max": 21.9 },
    "high_risk": { "min": 21.9, "max": 31 }
  },
  "fat_mass_index_references": {
    "low": { "min": 0, "max": 2.2 },
    "appropriate": { "min": 2.2, "max": 4.4 },
    "high": { "min": 4.4, "max": 6.6 }
  },
  "lean_mass_index_references": {
    "low": { "min": 13.6, "max": 17.4 },
    "appropriate": { "min": 17.4, "max": 21.2 },
    "high": { "min": 21.2, "max": 25 }
  },
  "waist_references": {
    "low_risk": { "min": 70, "max": 94 },
    "moderate": { "min": 94, "max": 102 },
    "high_risk": { "min": 102, "max": 118 }
  },
  "hip_references": {
    "attention": { "min": 93.3, "max": 97.2 },
    "low_risk": { "min": 97.2, "max": 104.8 },
    "moderate": { "min": 104.8, "max": 108.6 },
    "high_risk": { "min": 108.6, "max": 116.2 }
  },
  "waist_hip_references": {
    "adequate": { "min": 0.7, "max": 0.9 },
    "inappropriate": { "min": 0.9, "max": 1.15 }
  },
  "cardiovascular_risk_references": {
    "low_risk": { "min": 0.4, "max": 0.5 },
    "moderate": { "min": 0.5, "max": 0.55 },
    "high_risk": { "min": 0.55, "max": 0.7 }
  },
  "ic_index_references": {
    "adequate": { "min": 0.7, "max": 1.25 },
    "inappropriate": { "min": 1.25, "max": 1.4 }
  }
}
```
