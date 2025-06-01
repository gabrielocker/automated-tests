def get_attribute_response(response: dict, path: str):
    """
    Retrieves a nested value from a dictionary based on a dot-separated key path.
    
    Parameters:
        response (dict): The API response dictionary.
        path (str): Dot-separated string indicating the path to the desired value.
    
    Returns:
        The value if the path exists, otherwise None.
    """
    keys = path.split(".")
    data = response
    for key in keys:
        if isinstance(data, dict) and key in data:
            data = data[key]
        else:
            return None
    return data