'''
Initialize Config
'''
import os # pylint: disable=unused-import

class Config():
    """Application COnfiguration"""
    output_text = os.environ.get('output_text') or "<h1 style='color:blue'>Let's discuss Trivy!</h1>"
   
def myclassvariables():
    """Edit Class Variables"""
    temp = {}
    result = vars(Config)
    for key in result:
        if "__" not in key and "<" not in key and "myclassvariables" not in key :
            temp.update({key:result[key]})
    return temp