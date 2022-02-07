# encoding: utf-8

"""
Provides bridges between the model and plugin PluginImplementationss
"""
import logging
from operator import methodcaller
from typing import Any, Callable

from sqlalchemy.orm.session import SessionExtension  # type: ignore

import ckan.plugins as plugins


log = logging.getLogger(__name__)


class PluginSessionExtension(SessionExtension):  # type: ignore
    """
    Class that calls plugins implementing ISession on SQLAlchemy
    SessionExtension events
    """

    def notify_observers(self, func: Callable[[Any], None]) -> None:
        """
        Call func(observer) for all registered observers.

        :param func: Any callable, which will be called for each observer
        :returns: EXT_CONTINUE if no errors encountered, otherwise EXT_STOP
        """
        for observer in plugins.PluginImplementations(plugins.ISession):
            func(observer)

    def after_begin(self, session: Any, transaction: Any,
                    connection: Any) -> None:
        return self.notify_observers(
            methodcaller('after_begin', session, transaction, connection)
        )

    def before_flush(self, session: Any, flush_context: Any,
                     instances: Any) -> None:
        return self.notify_observers(
            methodcaller('before_flush', session, flush_context, instances)
        )

    def after_flush(self, session: Any, flush_context: Any) -> None:
        return self.notify_observers(
            methodcaller('after_flush', session, flush_context)
        )

    def before_commit(self, session: Any) -> None:
        return self.notify_observers(
            methodcaller('before_commit', session)
        )

    def after_commit(self, session: Any) -> None:
        return self.notify_observers(
            methodcaller('after_commit', session)
        )

    def after_rollback(self, session: Any) -> None:
        return self.notify_observers(
            methodcaller('after_rollback', session)
        )
