# automated-tests
Personal repository for demonstrating automated tests skills



🧍 User Attributes (results[<index>])
| Path     | Description                           |
| -------- | ------------------------------------- |
| `gender` | Gender of the user (`male`, `female`) |

👤 Name
| Path         | Description                       |
| ------------ | --------------------------------- |
| `name.title` | Title (`Mr`, `Mrs`, `Miss`, etc.) |
| `name.first` | First name                        |
| `name.last`  | Last name                         |

🌍 Location
| Path                             | Description                                     |
| -------------------------------- | ----------------------------------------------- |
| `location.street.number`         | Street number                                   |
| `location.street.name`           | Street name                                     |
| `location.city`                  | City                                            |
| `location.state`                 | State                                           |
| `location.country`               | Country                                         |
| `location.postcode`              | Postcode                                        |
| `location.coordinates.latitude`  | Latitude                                        |
| `location.coordinates.longitude` | Longitude                                       |
| `location.timezone.offset`       | Timezone offset (e.g., `+9:30`)                 |
| `location.timezone.description`  | Timezone description (e.g., `Adelaide, Darwin`) |

📧 Contact
| Path    | Description    |
| ------- | -------------- |
| `email` | Email address  |
| `phone` | Landline phone |
| `cell`  | Mobile phone   |

🔐 Login Credentials
| Path             | Description           |
| ---------------- | --------------------- |
| `login.uuid`     | Unique identifier     |
| `login.username` | Username              |
| `login.password` | Plain-text password   |
| `login.salt`     | Salt used for hashing |
| `login.md5`      | MD5 hash              |
| `login.sha1`     | SHA-1 hash            |
| `login.sha256`   | SHA-256 hash          |

🎂 Date of Birth
| Path       | Description             |
| ---------- | ----------------------- |
| `dob.date` | Birth date (ISO format) |
| `dob.age`  | Age                     |

📝 Registration Info
| Path              | Description              |
| ----------------- | ------------------------ |
| `registered.date` | Registration date        |
| `registered.age`  | Years since registration |

🆔 Identification
| Path       | Description             |
| ---------- | ----------------------- |
| `id.name`  | ID type (e.g., `SSN`)   |
| `id.value` | ID value (e.g., number) |

🖼️ Pictures
| Path                | Description         |
| ------------------- | ------------------- |
| `picture.large`     | Large photo URL     |
| `picture.medium`    | Medium photo URL    |
| `picture.thumbnail` | Thumbnail photo URL |

🌐 Nationality
| Path  | Description                          |
| ----- | ------------------------------------ |
| `nat` | Nationality (e.g., `US`, `FR`, etc.) |
