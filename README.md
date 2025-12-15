# Telemetry Creator

A Ruby script that generates synthetic time-series telemetry data in TypeScript format for testing and development purposes.

## Overview

This tool creates TypeScript files containing arrays of timestamped telemetry data points. It's useful for generating test data for IoT applications, monitoring dashboards, or any system that needs time-series data.

## Features

- Generates hourly telemetry data for configurable date ranges
- Supports multiple zones and parameters
- Outputs TypeScript files with exported constants
- Configurable value ranges via JSON configuration
- Generates 720 data points (30 days worth of hourly data)

## Usage

```bash
ruby main.rb [start_date] [end_date] [output_folder]
```

### Arguments

| Argument | Description | Default | Example |
|----------|-------------|---------|---------|
| `start_date` | Beginning date for data generation | `2025-01-01` | `2025-02-01` |
| `end_date` | Ending date for data generation | `2025-01-31` | `2025-02-28` |
| `output_folder` | Directory for generated files | `./output/` | `./data/` |

### Examples

```bash
# Use default dates and output folder
ruby main.rb

# Specify custom date range
ruby main.rb 2025-02-01 2025-02-28

# Specify all parameters
ruby main.rb 2025-03-01 2025-03-31 ./custom-output/
```

## Configuration

The script reads configuration from `config.json`, which should contain:

```json
{
  "zone_list": ["zone-1", "zone-2", "zone-3"],
  "params": [
    {
      "name": "temp_cel",
      "min": 18.0,
      "max": 26.0
    },
    {
      "name": "rh",
      "min": 30.0,
      "max": 60.0
    },
    {
      "name": "co2",
      "min": 400.0,
      "max": 1200.0
    },
    {
      "name": "current",
      "min": 0.5,
      "max": 10.0
    }
  ]
}
```

### Configuration Properties

- **zone_list**: Array of zone identifiers
- **params**: Array of parameter objects, each containing:
  - `name`: Parameter identifier (used in filenames and variable names)
  - `min`: Minimum value for random data generation
  - `max`: Maximum value for random data generation

## Output

The script generates TypeScript files with the naming pattern:

```
{parameter_name}-{zone}.ts
```

Each file exports a constant array with timestamped values:

```typescript
export const temp_cel_zone_1 = [
  {timestamp: '2025-01-01 00:00:00 +0000', value: 22.45},
  {timestamp: '2025-01-01 01:00:00 +0000', value: 21.78},
  {timestamp: '2025-01-01 02:00:00 +0000', value: 23.12},
  // ... 717 more entries
];
```

### Example Output Files

Based on the default configuration:
- `temp_cel-zone-1.ts`, `temp_cel-zone-2.ts`, `temp_cel-zone-3.ts`
- `rh-zone-1.ts`, `rh-zone-2.ts`, `rh-zone-3.ts`
- `co2-zone-1.ts`, `co2-zone-2.ts`, `co2-zone-3.ts`
- `current-zone-1.ts`, `current-zone-2.ts`, `current-zone-3.ts`

## Requirements

- Ruby 2.x or higher
- Standard Ruby libraries: `date`, `json`

## How It Works

1. **Parse Arguments**: Reads start date, end date, and output folder from command line
2. **Load Configuration**: Reads zone and parameter definitions from `config.json`
3. **Initialize Output**: Creates output directory if it doesn't exist
4. **Generate Data**: For each zone and parameter combination:
   - Creates a TypeScript file
   - Generates 720 hourly data points
   - Each data point has a timestamp and a random value within the configured range
5. **Export**: Writes data as TypeScript constant arrays

## Data Generation Details

- **Time Increment**: 1 hour (3600 seconds)
- **Data Points**: 720 entries per file (30 days × 24 hours)
- **Timestamp Format**: JavaScript-compatible timestamp string
- **Value Generation**: Random float within configured min/max range, rounded to 2 decimal places
- **Time Range**: From start_date 00:00:00 to end_date 23:59:59 (though 720 fixed iterations are used)

## License

[Add your license information here]

## Contributing

[Add contribution guidelines here]
