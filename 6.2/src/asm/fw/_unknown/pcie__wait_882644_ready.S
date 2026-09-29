/* pcie__wait_882644_ready @ 0x8d11f8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ack__8e026c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__wait_882644_ready
pcie__wait_882644_ready:
	.global L_8d11f8
L_8d11f8:
	mov_s r1,0xa5
L_8d11fa:
	mov lp_count,0x5281
L_8d1202:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8d1204:
	lp L_8d1216
L_8d1208:
	mov_s r0,0x882600
L_8d120e:
	ld_s r0,[r0,0x44]
L_8d1210:
	bbit0 r0,0x1d,L_8d1216
L_8d1214:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8d1216
L_8d1216:
	cmp_s r1,0x0
L_8d1218:
	mov_s r0,0x1
L_8d121a:
	j_s.d [blink]
L_8d121c:
	sub.le r0,r0,r0
