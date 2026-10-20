/* tx_initiator__reset_slot_counters @ 0x92fd74, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_initiator__reset_slot_counters
tx_initiator__reset_slot_counters:
	.global L_92fd74
L_92fd74:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92fd76:
	add1_s r0,r0,r0
L_92fd78:
	add_s r0,r0,0x802610
L_92fd7e:
	mov_s r2,0x0
L_92fd80:
	st_s r2,[r0]
L_92fd82:
	ld_s r1,[r0,0x4]
L_92fd84:
	st_s r1,[r0,0x8]
L_92fd86:
	j_s.d [blink]
L_92fd88:
	st_s r2,[r0,0x4]
L_92fd8a:
	nop_s
