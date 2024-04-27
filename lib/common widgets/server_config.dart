String IP = '192.168.201.24';
int PORT = 8000;
String BASE_URL = 'http://$IP:${PORT}/';

Uri TEST_API = Uri.parse('${BASE_URL}test/');

Uri DASHBOARD_API = Uri.parse('${BASE_URL}dashboard');
Uri PHYSICAL_API = Uri.parse('${BASE_URL}physical/');
