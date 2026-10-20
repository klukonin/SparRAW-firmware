/* wmi_evt__init_desc @ 0x8d9174, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__add_sniffer_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__init_desc
wmi_evt__init_desc:
	.global L_8d9174
L_8d9174:
	push_s r13
L_8d9176:
	mov_s r13,0x0
L_8d9178:
	st_s r13,[r0,0x18]
L_8d917a:
	stw_s r1,[r0]
L_8d917c:
	mov_s r1,0x18
L_8d917e:
	stw_s r1,[r0,0x2]
L_8d9180:
	st_s r2,[r0,0x4]
L_8d9182:
	st_s r3,[r0,0x8]
L_8d9184:
	st_s r13,[r0,0x14]
L_8d9186:
	mov_s r1,0x1
L_8d9188:
	st_s r1,[r0,0x18]
L_8d918a:
	st_s r13,[r0,0x1c]
L_8d918c:
	st_s r13,[r0,0x24]
L_8d918e:
	st_s r13,[r0,0x28]
L_8d9190:
	st_s r13,[r0,0x2c]
L_8d9192:
	st_s r13,[r0,0xc]
L_8d9194:
	st_s r13,[r0,0x30]
L_8d9196:
	st_s r13,[r0,0x34]
L_8d9198:
	st_s r13,[r0,0x20]
L_8d919a:
	j_s.d [blink]
L_8d919c:
	pop_s r13
L_8d919e:
	nop_s
