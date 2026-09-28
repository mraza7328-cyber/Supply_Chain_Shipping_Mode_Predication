from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import pickle
import pandas as pd
from pathlib import Path


# Create FastAPI app
app = FastAPI(
    title="Supply Chain Shipping Mode Predictor",
    description="Machine Learning model for Shipping Mode prediction",
    version="1.0"
)


# Get app folder path
BASE_DIR = Path(__file__).resolve().parent


# Load trained model
with open(BASE_DIR / "model_artifacts.pkl", "rb") as file:
    artifacts = pickle.load(file)


model = artifacts["model"]
encoder = artifacts["encoder"]
label_encoder = artifacts["label_encoder"]
feature_columns = artifacts["feature_columns"]


# Input data
class PredictionInput(BaseModel):
    features: dict


# Home page
@app.get("/")
def home():
    return {
        "message": "Supply Chain Shipping Mode Prediction API is running",
        "features": feature_columns
    }


# Prediction
@app.post("/predict")
def predict(data: PredictionInput):

    input_df = pd.DataFrame([data.features])

    # Keep same feature order
    input_df = input_df.reindex(columns=feature_columns)

    # Get categorical columns
    categorical_columns = encoder.feature_names_in_

    # Apply the same encoder used during training
    input_df[categorical_columns] = encoder.transform(
        input_df[categorical_columns]
    )

    # Convert values to numeric
    input_df = input_df.apply(pd.to_numeric, errors="coerce")

    # Fill missing values
    input_df = input_df.fillna(0)

    # Prediction
    prediction = model.predict(input_df)

    # Convert encoded value back to Shipping Mode
    shipping_mode = label_encoder.inverse_transform(
        prediction.astype(int)
    )[0]

    return {
        "prediction": shipping_mode
    }


# Static folder
app.mount(
    "/static",
    StaticFiles(directory=BASE_DIR / "static"),
    name="static"
)