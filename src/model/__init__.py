"""
Model module for GRAM
Contains FiD-T5 and related model implementations
"""

from .gram import GRAM


def create_model(model_type, config=None, **kwargs):
    """
    Factory function to create models

    Args:
        model_type (str): 'gram' or other model types
        config: Model configuration
        **kwargs: Additional arguments

    Returns:
        Model instance
    """
    if model_type == "gram":
        return GRAM(config=config, **kwargs)
    else:
        raise ValueError(f"Unknown model type: {model_type}")


__all__ = ["GRAM", "create_model"]
