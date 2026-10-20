/* connection__dec_stream_count @ 0x8c7164, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection.cpp
 * Зовут его: STREAM_MGR__2
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, stream__inject_evt1
 */
	.section .text.connection__dec_stream_count,"ax",@progbits
	.global connection__dec_stream_count
connection__dec_stream_count:
	.global L_8c7164
L_8c7164:
	push_s blink
L_8c7166:
	push_s r13
L_8c7168:
	mov_s r13,r0
L_8c716a:
	ldb_s r0,[r0,0xa]
L_8c716c:
	brlt r0,0x1,L_8c7186
	.global L_8c7170
L_8c7170:
	ldb_s r0,[r13,0xa]
L_8c7172:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c7174:
	extb.f r0,r0
L_8c7178:
	stb_s r0,[r13,0xa]
L_8c717a:
	bl.eq.d L_8e3250
L_8c717e:
	mov.eq r0,r13
L_8c7182:
	b L_8c033c
	.global L_8c7186
L_8c7186:
	mov_s r0,blink
L_8c7188:
	mov_s r2,0x100e298
L_8c718e:
	mov_s r1,0x47
L_8c7190:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8c7192:
	bl.d L_8c82c0
L_8c7196:
	mov r3,0x1dc
L_8c719a:
	b_s L_8c7170
