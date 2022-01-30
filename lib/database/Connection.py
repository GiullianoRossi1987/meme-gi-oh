# coding = UTF-8
# using namespace std
import psycopg2 as psql
from typing import AnyStr

class Connection:
	"""
	"""

	DB     = "meme_gi_oh"
	USER   = "disc_mgo"
	HOST   = "127.0.0.1"
	PASSWD = "disc-fds"

	_connector    = None
	_connector_on = False

	def __init__(self):
		"""
		"""
		self._connector = psql.connect(
			database  = Connection.DB, 
			user      = Connection.USER,
			password  = Connection.PASSWD,
			host      = Connection.HOST
		)
		self._connector_on = True
	
	def __del__(self):
		"""
		"""
		if self._connector_on: 
			self._connector.commit()
			self._connector.close()
	
	def __enter__(self):
		"""
		"""
		if not self._connector_on: self._connector_on = True
	
	def __exit__(self):
		"""
		"""
		if self._connector_on:
			self._connector.commit()
			self._connector.close()
	
	def get_cursor(self):
		"""
		"""
		if self._connector_on: 
			cur = self._connector.cursor()  # just in case
			return cur

	def dispose(self):
		"""
		"""
		if self._connector_on:
			self._connector.commit()
			self._connector.close()
			self._connector_on = False
	




