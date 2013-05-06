from functools import wraps
import sys
import pdb
import traceback

def pdb_on_error(func):
    @wraps(func)
    def pdbd(*args, **kwargs):
        try:
            func(*args, **kwargs)
        except Exception, e:
            print '\n' + '=' * 30 + ' pdb_on_error ' + '=' * 30
            traceback.print_exc(file=sys.stdout)
            pdb.Pdb(stdin=sys.__stdin__, stdout=sys.__stdout__).set_trace()
    return pdbd

def ipdb_on_error(func):
    @wraps(func)
    def ipdbd(*args, **kwargs):
        import ipdb
        try:
            func(*args, **kwargs)
        except Exception, e:
            print '\n' + '=' * 30 + ' ipdb_on_error ' + '=' * 30
            traceback.print_exc(file=sys.stdout)
            ipdb.set_trace()
    return ipdbd

def trace(func):
    @wraps(func)
    def traced(*args, **kwargs):
        ret = func(*args, **kwargs)
        print '%s(*(%s), **(%s)) -> %s' % (func.func_name, args, kwargs, repr(ret))
        return ret

    return traced
