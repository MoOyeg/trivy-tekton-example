'''
Initialize Application
'''

import os # pylint: disable=unused-import
from flask import Flask, request, current_app # pylint: disable=unused-import


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config['DEBUG'] = True
    app.config.from_object(config_class)
    from app.main import bp as main_bp
    app.register_blueprint(main_bp)
    return app