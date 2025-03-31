# Pokemon API BFF

Backend for Frontend (BFF) service for the Pokemon API application.

## Setup

1. Install dependencies:

```bash
npm install
```

2. Create a `.env` file in the root directory with the following variables:

```env
PORT=3000
POKEAPI_URL=https://pokeapi.co/api/v2
```

## Development

Run the development server:

```bash
npm run dev
```

## Build

Build the project:

```bash
npm run build
```

## Production

Start the production server:

```bash
npm start
```

## Testing

Run tests:

```bash
npm test
```

## API Endpoints

### Health Check

- `GET /health` - Health check endpoint

### Pokemon Endpoints

- `GET /api/pokemon` - Get list of pokemons with pagination

  - Query parameters:
    - `limit` (optional): Number of pokemons to return (default: 20)
    - `offset` (optional): Number of pokemons to skip (default: 0)

- `GET /api/pokemon/:id` - Get pokemon by ID

  - Path parameters:
    - `id`: Pokemon ID

- `GET /api/pokemon/search` - Search pokemons by name

  - Query parameters:
    - `q`: Search query

- `GET /api/pokemon/type/:type` - Get pokemons by type

  - Path parameters:
    - `type`: Pokemon type (e.g., fire, water, grass)

- `GET /api/pokemon/ability/:ability` - Get pokemons by ability
  - Path parameters:
    - `ability`: Pokemon ability (e.g., blaze, overgrow)

## Response Format

All endpoints return JSON responses in the following format:

```json
{
  "id": number,
  "name": string,
  "types": string[],
  "abilities": string[],
  "height": number,
  "weight": number,
  "baseExperience": number,
  "imageUrl": string
}
```
