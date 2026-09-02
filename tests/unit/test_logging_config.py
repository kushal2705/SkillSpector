# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

"""Tests for package logging configuration."""

import logging
import re

from skillspector.logging_config import get_logger


def test_package_log_formatter_includes_timestamp() -> None:
    logger = get_logger("skillspector.timestamp_test")
    package_logger = logging.getLogger("skillspector")

    assert logger.name == "skillspector.timestamp_test"
    assert package_logger.handlers
    formatter = package_logger.handlers[0].formatter
    assert formatter is not None

    record = logging.LogRecord(
        name=logger.name,
        level=logging.INFO,
        pathname=__file__,
        lineno=1,
        msg="message",
        args=(),
        exc_info=None,
    )
    rendered = formatter.format(record)

    assert re.match(
        r"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]\d{4} INFO "
        r"\[skillspector\.timestamp_test\] message$",
        rendered,
    )