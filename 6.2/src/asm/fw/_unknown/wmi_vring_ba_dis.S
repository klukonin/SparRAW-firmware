/* wmi_vring_ba_dis @ 0x8fb490, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, stream_mgr__ba_disable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_vring_ba_dis
wmi_vring_ba_dis:
	.global L_8fb490
L_8fb490:
	push_s blink
L_8fb492:
	push_s r13
L_8fb494:
	ldb_s r13,[r0]
L_8fb496:
	brhs r13,0xa,L_8fb4a4
	.global L_8fb49a
L_8fb49a:
	bl.d L_8c4200
L_8fb49e:
	mov_s r0,r13
L_8fb4a0:
	b L_8c025c
	.global L_8fb4a4
L_8fb4a4:
	mov_s r0,blink
L_8fb4a6:
	mov_s r1,0x11de
L_8fb4ac:
	bl L_8c9b28
L_8fb4b0:
	b_s L_8fb49a
L_8fb4b2:
	nop_s
