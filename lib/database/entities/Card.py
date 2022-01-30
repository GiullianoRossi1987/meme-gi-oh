# encoding = UTF-8
# using namespace std
from ..Connection import Connection
from typing import List, Tuple

class Card:
	"""
	"""

	_cd: int
	_name: str
	_dsc: str
	_attack: float
	_deffense: float
	_hp: float
	_price: float
	_rareness: str

	def __init__(self, data):
		"""
		"""
		self._cd   = data[0]
		self._name = data[1]
		self._dsc  = data[2]


