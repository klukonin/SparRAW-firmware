// SPDX-License-Identifier: AGPL-3.0-or-later
/* Split MAC точки (6.4, прошивка apsta): ответы на ассоциацию от hostapd.
 *
 * handle_packet_splitmac принимает от хоста (WMI_SW_TX_REQ) только
 * Association Response (подтип 1) и Disassociation (10), прочее молча
 * отбрасывает.  Reassociation Response (3) по формату тела совпадает с
 * Association Response (802.11-2020 9.3.3.6, 9.3.3.8), заголовок хоста
 * копируется как есть — достаточно вести его той же веткой.  Патч 0016
 * заменяет извлечение подтипа из FC (lsr_s + bmsk_s, 4 байта) вызовом
 * вставки ниже: r0 = FC → r0 = подтип, 3 → 1.  Меняет только r0.
 */
__asm__(
	"	.section .text.splitmac_subtype,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global splitmac__fc_subtype\n"
	"splitmac__fc_subtype:\n"
	"	lsr r0,r0,4\n"
	"	and r0,r0,0xf\n"
	"	cmp r0,3\n"
	"	j.d [blink]\n"
	"	mov.eq r0,1\n");
