import sys
import psycopg2
from PyQt6 import QtWidgets, QtCore
from PyQt6.QtWidgets import QListWidgetItem

# Настройки подключения к базе данных
DB_CONFIG = {
    "dbname": "mydb",
    "user": "postgres",
    "password": "111",
    "host": "localhost",
    "port": "5433"
}


class Database:
    def __init__(self):
        self.conn = psycopg2.connect(**DB_CONFIG)
        self.cur = self.conn.cursor()

    def get_family_members(self):
        self.cur.execute("SELECT member_id, full_name FROM family_members ORDER BY full_name")
        return self.cur.fetchall()

    def get_member_details(self, member_id):
        self.cur.execute(
            """
            SELECT fm.full_name, fm.date_of_birth, mj.position, mj.company, COALESCE(mj.salary, 0)
            FROM family_members fm
            LEFT JOIN member_jobs mj ON fm.member_id = mj.member_id
            WHERE fm.member_id = %s
            """, (member_id,)
        )
        return self.cur.fetchone()

    def calculate_budget_ratio(self, member_id):
        self.cur.execute(
            """
            SELECT COALESCE(SUM(e.quantity * p.price), 0)
            FROM expenses e
            JOIN products p ON e.product_id = p.product_id
            WHERE e.member_id = %s AND e.purchase_date >= date_trunc('month', CURRENT_DATE)
            """, (member_id,)
        )
        total_expenses = self.cur.fetchone()[0]

        self.cur.execute("SELECT COALESCE(salary, 0) FROM member_jobs WHERE member_id = %s", (member_id,))
        total_income = self.cur.fetchone()
        total_income = total_income[0] if total_income else 0

        if total_income > total_expenses:
            return "Профицит бюджета"
        return "Дефицит бюджета"

    def close(self):
        self.cur.close()
        self.conn.close()


class MainWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Семейный бюджет")
        self.setGeometry(100, 100, 800, 600)
        self.db = Database()
        self.setup_ui()
        self.load_family_members()

    def setup_ui(self):
        self.list_view = QtWidgets.QListWidget(self)
        self.list_view.setGeometry(10, 10, 300, 580)
        self.list_view.itemClicked.connect(self.display_member_details)

        self.details_widget = QtWidgets.QWidget(self)
        self.details_widget.setGeometry(320, 10, 460, 200)
        self.details_layout = QtWidgets.QVBoxLayout(self.details_widget)

        self.name_label = QtWidgets.QLabel("ФИО: ", self)
        self.age_label = QtWidgets.QLabel("Возраст: ", self)
        self.position_label = QtWidgets.QLabel("Должность: ", self)
        self.company_label = QtWidgets.QLabel("Компания: ", self)
        self.salary_label = QtWidgets.QLabel("Оклад: ", self)
        self.budget_status_label = QtWidgets.QLabel("Бюджет: ", self)

        for label in [self.name_label, self.age_label, self.position_label, self.company_label, self.salary_label,
                      self.budget_status_label]:
            self.details_layout.addWidget(label)

    def load_family_members(self):
        members = self.db.get_family_members()
        for member_id, full_name in members:
            item = QListWidgetItem(full_name)
            item.setData(QtCore.Qt.ItemDataRole.UserRole, member_id)
            self.list_view.addItem(item)

    def display_member_details(self, item):
        member_id = item.data(QtCore.Qt.ItemDataRole.UserRole)
        details = self.db.get_member_details(member_id)
        budget_status = self.db.calculate_budget_ratio(member_id)



        if details:
            full_name, birth_date, position, company, salary = details
            age = QtCore.QDate.currentDate().year() - birth_date.year
            self.name_label.setText(f"ФИО: {full_name}")
            self.age_label.setText(f"Возраст: {age} лет")
            self.position_label.setText(f"Должность: {position if position else 'Безработный'}")
            self.company_label.setText(f"Компания: {company if company else '-'}")
            self.salary_label.setText(f"Оклад: {salary} руб.")
            self.budget_status_label.setText(f"Бюджет: {budget_status}")

    def closeEvent(self, event):
        self.db.close()
        event.accept()


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
