import socket
import threading
import os
import struct
import time


def check_sum(packet):
    even_sum = sum(map(ord, packet[::2]))
    odd_sum = sum(map(ord, packet[1::2]))
    return (100 - (((even_sum * 3) + odd_sum) % 100)) % 100


dt = time.monotonic()
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
source_port = 8000
s.bind(("localhost", source_port))
print("\t\t\t====>  UDP CHAT APP  <=====")
print("==============================================")
username = input("ENTER YOUR NAME : ")
print(f"\n Your IP: localhost, your source_port {source_port}")
print("\nType 'quit' to exit.")

ip, dest_port = input("Enter IP address and Port number of destination: ").split()


def send():
    while True:
        ms = input(">> ")
        date_send = time.monotonic()

        if ms == "quit":
            os._exit(0)

        sm = f"{username}: {ms}"
        udp_header = struct.pack("!IIIII", source_port, int(dest_port), len(sm), check_sum(sm), int(date_send))
        packet_with_header = udp_header + sm.encode()
        s.sendto(packet_with_header, (ip, int(dest_port)))


def rec():
    last_date_send = dt

    while True:
        full_packet, sender_address = s.recvfrom(1024)
        udp_header = full_packet[:20]
        data = full_packet[20:].decode()

        udp_header = struct.unpack("!IIIII", udp_header)
        correct_checksum = udp_header[3]
        correct_data_len = udp_header[2]
        checksum = check_sum(data)

        date_send = udp_header[4]
        is_correct_msg_order = date_send >= last_date_send

        if correct_checksum == checksum and correct_data_len == len(data) and is_correct_msg_order:
            last_date_send = date_send
            print("\t\t\t\t >> " + data)
            print(">> ")

        elif not is_correct_msg_order:
            raise("Incorrect order of msg")

        else:
            raise("Not all data was passed")


x1 = threading.Thread(target=send)
x2 = threading.Thread(target=rec)

x1.start()
x2.start()


