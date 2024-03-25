import ctypes
# NtResumeThread
# Carregar a biblioteca de rede do Windows
iphlpapi = ctypes.WinDLL('iphlpapi.dll')

# Definir a estrutura MIB_TCPROW2
class MIB_TCPROW2(ctypes.Structure):
    _fields_ = [
        ("dwState", ctypes.c_ulong),
        ("dwLocalAddr", ctypes.c_ulong),
        ("dwLocalPort", ctypes.c_uint),
        ("dwRemoteAddr", ctypes.c_ulong),
        ("dwRemotePort", ctypes.c_uint),
        ("dwOwningPid",ctypes.c_ulong),

    ]

# Chamar a função GetTcpTable2
def get_tcp_table2():
    table = (MIB_TCPROW2 * 100)()
    table_size = ctypes.c_ulong(ctypes.sizeof(table))
    result = iphlpapi.GetTcpTable2(ctypes.byref(table), ctypes.byref(table_size), True)
    
    if result == 0:
        # Iterar sobre as entradas da tabela e imprimir informações
        for entry in table:
            print(f"Local Address: {entry.dwLocalAddr}, Local Port: {entry.dwLocalPort}")
            print(f"Remote Address: {entry.dwRemoteAddr}, Remote Port: {entry.dwRemotePort}")
            print(f"State: {entry.dwState}")
            print(f"PID: {entry.dwOwningPid}")
    else:
        print(f"Erro ao chamar GetTcpTable2: {result}")

if __name__ == "__main__":
    get_tcp_table2()
