# CineSense AI — Movie Review Sentiment Analysis

An end-to-end, locally running Sentiment Analysis application powered by a **genuine PyTorch Bidirectional LSTM Neural Network**, a **Flask REST API**, an **SQLite** database, and a **modern React** dashboard.

---

## 🌟 Key Features

1. **Clean, Modern Dashboard**: Glassmorphic dark cinematic UI built with React & CSS with real-time model status indicators.
2. **Review Analyzer**: Text input with word/character counter, quick-fill sample review buttons, and real-time input validation.
3. **Genuine LSTM Sentiment Predictions**: Real classification into `Positive` or `Negative` sentiment without hardcoded heuristics.
4. **Authentic Confidence Scores**: Derived from the model's Sigmoid posterior probability distribution (50.0% to 100.0%).
5. **SQLite History Persistence**: All predictions, reviews, word counts, and timestamps are automatically stored in `backend/cinesense.db`.
6. **Live Analytics & Trends**: Dynamic positive vs. negative review counters, percentage ratios, and average confidence gauge.
7. **Robust Error Handling**: Graceful loading spinners, server offline detection, and validation alerts.

---

## 🏗️ Architecture & Project Structure

```
cinesense-ai/
├── backend/
│   ├── app.py                # Flask REST API server & endpoints
│   ├── db.py                 # SQLite database layer & analytics aggregations
│   ├── model.py              # PyTorch Bidirectional LSTM model & inference class
│   ├── dataset.py            # Tokenizer, vocabulary builder, & curated IMDb reviews
│   ├── train.py              # Reproducible model training pipeline
│   ├── download_imdb.py      # Downloader script for full 50,000 Stanford IMDb dataset
│   ├── verify_e2e.py         # End-to-end verification test suite
│   ├── cinesense.db          # Local SQLite database
│   ├── data/
│   │   ├── vocab.json        # Saved vocabulary token mappings (433 tokens)
│   │   └── model.pt          # Saved trained LSTM weights
│   ├── tests/
│   │   ├── test_model.py     # Model unit tests (tokenization, inference, bounds)
│   │   ├── test_db.py        # Database unit tests (schema, CRUD, metrics)
│   │   └── test_api.py       # Flask API integration tests (health, predict, history)
│   └── requirements.txt      # Python backend dependencies
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Header.jsx    # Branding & live status badge
│   │   │   ├── ReviewForm.jsx# Input form, sample buttons, validation
│   │   │   ├── ResultCard.jsx# Sentiment prediction & confidence meter
│   │   │   ├── Analytics.jsx # Ratio bars & summary metrics
│   │   │   └── History.jsx   # Persisted history list & delete actions
│   │   ├── api.js            # API client with error handling
│   │   ├── App.jsx           # Main application state coordinator
│   │   ├── App.css           # Modern styling & animations
│   │   └── main.jsx          # React DOM entry point
│   ├── package.json          # Node dependencies (React 19, Vite)
│   └── vite.config.js        # Vite dev server with /api proxy to Flask :5000
├── docs/
│   └── DATASET_GUIDE.md      # Instructions for full 50,000 IMDb dataset
├── run_backend.bat           # 1-click backend Windows batch launcher
├── run_frontend.bat          # 1-click frontend Windows batch launcher
├── run_backend.ps1           # PowerShell backend launcher
└── run_frontend.ps1          # PowerShell frontend launcher
```

---

## 🚀 Setup & Startup Instructions

### 1. Prerequisites
- **Python**: 3.10+ (tested and verified on Python 3.14.4)
- **Node.js**: v18+ (tested and verified on Node.js v26.13.0)
- **npm**: 9+ (tested and verified on npm 11.20.0)

### 2. Dependency Installation
Backend dependencies are installed inside the Python virtual environment:
```powershell
.\.venv\Scripts\pip.exe install -r backend\requirements.txt
```

Frontend packages are installed inside the `frontend/` directory:
```powershell
$env:PATH = "C:\Program Files\nodejs;" + $env:PATH
Set-Location frontend
& "C:\Program Files\nodejs\npm.cmd" install
Set-Location ..
```

### 3. Model Training (Reproducible)
To retrain the Bidirectional LSTM model and regenerate vocabulary:
```powershell
.\.venv\Scripts\python.exe backend\train.py
```
> Trained model weights are saved to `backend/data/model.pt` and vocabulary to `backend/data/vocab.json`.

### 4. Running the Application

#### Option A: Quick 1-Click Launchers
1. Double-click **`run_backend.bat`** (Starts Flask on `http://127.0.0.1:5000`)
2. Double-click **`run_frontend.bat`** (Starts Vite on `http://localhost:3000`)

#### Option B: PowerShell Commands
* Terminal 1 (Backend):
  ```powershell
  .\.venv\Scripts\python.exe backend\app.py
  ```
* Terminal 2 (Frontend):
  ```powershell
  $env:PATH = "C:\Program Files\nodejs;" + $env:PATH
  Set-Location frontend
  & "C:\Program Files\nodejs\npm.cmd" run dev
  ```

Open your browser to: **`http://localhost:3000`**

---

## 📡 REST API Endpoints Reference

| Method | Endpoint | Description | Request Body / Parameters | Response Example |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/health` | Backend and model status | None | `{"status": "healthy", "model_loaded": true, "vocab_size": 433}` |
| `POST` | `/api/predict` | Predicts review sentiment & stores in SQLite | `{"review": "Great movie!"}` | `{"success": true, "prediction": {"id": 1, "sentiment": "Positive", "confidence": 98.4, "raw_probability": 0.984}}` |
| `GET` | `/api/history` | Fetches saved reviews | Query: `limit=50&offset=0` | `{"success": true, "count": 1, "reviews": [...]}` |
| `GET` | `/api/analytics` | Summary sentiment metrics | None | `{"success": true, "analytics": {"total_reviews": 10, "positive_count": 6, "positive_percentage": 60.0, "avg_confidence": 92.5}}` |
| `DELETE` | `/api/history/<id>` | Deletes individual review | None | `{"success": true, "deleted_id": 1}` |
| `DELETE` | `/api/history` | Clears all stored reviews | None | `{"success": true, "deleted_count": 10}` |

---

## 🧪 Testing Instructions

### Automated Unit and Integration Tests
Run pytest across all backend suites:
```powershell
.\.venv\Scripts\pytest.exe backend\tests -v
```
*(Covers model predictions, empty input validation, token padding, database CRUD, and Flask endpoints)*

### Live HTTP & SQLite End-to-End Verification
```powershell
.\.venv\Scripts\python.exe backend\verify_e2e.py
```
*(Starts a test server, verifies `/api/health`, submits positive & negative reviews, tests analytics, and queries SQLite records on disk)*

---

## 🔧 Troubleshooting Guidance

1. **"The file cannot be accessed by the system" or Python Access Denied**:
   - Ensure you invoke Python through the virtual environment binary: `.\.venv\Scripts\python.exe`.
2. **"npm : File ... npm.ps1 cannot be loaded because running scripts is disabled"**:
   - Windows PowerShell restricts `.ps1` execution policies. Run `npm.cmd` directly: `& "C:\Program Files\nodejs\npm.cmd" run dev` or run `run_frontend.bat`.
3. **Frontend displays "Backend Offline"**:
   - Ensure the Flask backend is running on `http://127.0.0.1:5000`. Click the **↻ Retry** button in the dashboard header once started.
4. **SQLite "database is locked" error**:
   - The database layer automatically closes connections in `finally` blocks. If locked by an external SQLite browser, close the external viewer.
