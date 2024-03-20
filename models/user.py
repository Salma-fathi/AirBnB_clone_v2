#!/usr/bin/python3
"""This module defines a class User"""
from models.base_model import BaseModel


class User(BaseModel):
    """This class defines a user by various attributes,Represents a user for a MySQL database.

    Inherits from SQLAlchemy Base and links to the MySQL table users.
"""

    __tablename__ = "users"
    email = Column(String(128), nullable =False)
    password = Column(String(128), nullable =False)
    first_name = Column(String(128), nullable =False)
    last_name = Column(String(128), nullable =False)
