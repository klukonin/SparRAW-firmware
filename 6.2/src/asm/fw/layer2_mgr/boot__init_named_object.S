/* boot__init_named_object @ 0x8f2044, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_subsystems
 * Зовёт сам: __ld_r13_to_r13_ret, mlme_sm__data_port_open_ev_handle
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__init_named_object
boot__init_named_object:
	.global L_8f2044
L_8f2044:
	push_s blink
L_8f2046:
	push_s r13
L_8f2048:
	mov_s r6,r0
L_8f204a:
	mov_s r0,r2
L_8f204c:
	mov_s r5,r3
L_8f204e:
	mov_s r13,0x0
L_8f2050:
	b_s L_8f2056
	.global L_8f2052
L_8f2052:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f2054:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8f2056
L_8f2056:
	ldb_s r3,[r1,r0]
L_8f2058:
	brne_s r3,0,L_8f2052
L_8f205a:
	add r4,r13,0x1
L_8f205e:
	extb r4,r4
L_8f2062:
	mov_s r0,r6
L_8f2064:
	bl.d L_8f2070
L_8f2068:
	mov_s r3,r5
L_8f206a:
	b.d L_8c025c
L_8f206e:
	extw_s r0,r13
