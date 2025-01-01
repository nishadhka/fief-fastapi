from dotenv import load_dotenv
import os

import fsspec
from google.oauth2 import service_account

import xarray as xr
import gcsfs
import zarr

# Load environment variables from .env file
load_dotenv()

service_account_json = os.getenv("credentials")
zarr_store_path=os.getenv("zarr_store_path")
# Path to your service account key file

# Create credentials object
credentials = service_account.Credentials.from_service_account_file(
    service_account_json,
    scopes=["https://www.googleapis.com/auth/devstorage.read_only"],
  # Adjust scopes if needed
)


fs = fsspec.filesystem("gs", token=credentials)
# Get the mapper
m = fs.get_mapper(zarr_store_path)
# Open the dataset using xarray
ds = xr.open_zarr(m, consolidated=False)
ds
