from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class DBSettings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="DB_")

    HOST: str = "db"
    PORT: int = 5432
    USER: str = "postgres"
    PASSWORD: str = "password"
    NAME: str = "postgres"
    POOL_SIZE: int = 5
    POOL_OVERFLOW: int = 10
    POOL_RECYCLE: int = 3600

    ECHO: bool = False


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="promo_site/.env", env_file_encoding="utf-8"
    )

    ENVIRONMENT_NAME: Literal["local", "dev", "staging", "main"] = "local"
    NUMBER_OF_WORKERS: int = 1
    DEBUG: bool = False
    TESTING: bool = False
    RELOAD: bool = False

    db: DBSettings = DBSettings()
