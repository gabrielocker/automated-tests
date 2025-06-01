import requests

class RandomUserGenerator:
    def __init__(self):
        self.base_url = 'https://randomuser.me/api/'
        self.users = []

    def generate_users(self, quantity=1):
        """Calls the API and stores the generated users"""
        params = {'results': quantity}
        try:
            response = requests.get(self.base_url, params=params)
            response.raise_for_status()
            self.users = response.json().get('results', [])
            print(self.users)
        except requests.RequestException as e:
            print(f"Error accessing the API: {e}")
            self.users = []
        return self.users

    def get_attribute(self, user_index, path):
        """
        Dynamically accesses an attribute of a generated user.
        `path` should be a dot-separated string of keys, e.g., "location.street.name"
        """
        user_index = int(user_index)

        if not (0 <= user_index < len(self.users)):
            raise IndexError("Invalid user index.")

        current = self.users[user_index]
        for key in path.split('.'):
            if isinstance(current, dict) and key in current:
                current = current[key]
            else:
                raise KeyError(f"Key '{key}' not found in the given path.")
        return current


instance = None

def instance_randomuser():
    global instance
    instance = RandomUserGenerator()

def generate_users(quantity):
    global instance
    return instance.generate_users(quantity)

def get_attribute(user_index, path):
    global instance
    return instance.get_attribute(user_index, path)