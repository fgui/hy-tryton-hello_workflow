import hy
from trytond.pool import Pool
from . import hello_workflow


def register():
    Pool.register(
        hello_workflow.Hello,
        module='hello_workflow', type_='model')
