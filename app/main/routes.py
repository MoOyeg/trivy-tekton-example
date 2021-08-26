'''
Initialize Application Routes
'''
from datetime import datetime # pylint: disable=unused-import
from flask import render_template, flash, redirect, url_for, request, g, \
    jsonify, current_app, make_response # pylint: disable=unused-import
from app.main import bp # pylint: disable=unused-import
from config import Config # pylint: disable=unused-import
from config import myclassvariables # pylint: disable=unused-import

@bp.route('/', methods=['GET', 'POST'])
@bp.route('/index', methods=['GET', 'POST'])
def index():
    """Application Configuration"""
    configs = myclassvariables()
    fullurl = request.base_url
    return Config.output_text
