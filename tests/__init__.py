try:
    from trytond.modules.hello_workflow.tests.test_hello import suite
except ImportError:
    from .test_hello import suite


__all__ = ['suite']
