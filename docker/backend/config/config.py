import os
from dataclasses import dataclass


@dataclass
class Settings:
    EXAMPLE_VARIABLE: str = os.getenv("EXAMPLE_VARIABLE", default="something")
    PROJECT_NAME: str = "Immfly-test"
    PROJECT_VERSION: str = "0.0.1"


settings = Settings()
