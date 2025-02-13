# set the base image
FROM python:3.12-slim

# install lightgbm dependency
RUN apt-get update && apt-get install -y libgomp1

# set up the working directory
WORKDIR /app

# copy the requirements file
COPY requirements-dockers.txt ./

# install the packages
RUN pip install -r requirements-dockers.txt

# copy the app contents
COPY app.py ./
COPY ./models/preprocessor.joblib ./models/preprocessor.joblib
COPY ./scripts/data_clean_utils.py ./scripts/data_clean_utils.py
COPY ./run_information.json ./

# expose the port
EXPOSE 8000

# Run the FastAPI app with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]