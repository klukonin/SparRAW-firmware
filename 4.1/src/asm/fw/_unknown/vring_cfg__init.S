/* vring_cfg__init @ 0x8d6104, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__add_sniffer_vring
 */
	.section .text.vring_cfg__init,"ax",@progbits
	.global vring_cfg__init
vring_cfg__init:
	.global L_8d6104
L_8d6104:
	push_s r13
L_8d6106:
	mov_s r13,0x0
L_8d6108:
	st_s r13,[r0,0x18]
L_8d610a:
	stw_s r1,[r0]
L_8d610c:
	mov_s r1,0x18
L_8d610e:
	stw_s r1,[r0,0x2]
L_8d6110:
	st_s r2,[r0,0x4]
L_8d6112:
	st_s r3,[r0,0x8]
L_8d6114:
	st_s r13,[r0,0x14]
L_8d6116:
	mov_s r1,0x1
L_8d6118:
	st_s r1,[r0,0x18]
L_8d611a:
	st_s r13,[r0,0x1c]
L_8d611c:
	st_s r13,[r0,0x20]
L_8d611e:
	st_s r13,[r0,0x24]
L_8d6120:
	st_s r13,[r0,0x28]
L_8d6122:
	st_s r13,[r0,0xc]
L_8d6124:
	st_s r13,[r0,0x2c]
L_8d6126:
	st_s r13,[r0,0x30]
L_8d6128:
	j_s.d [blink]
L_8d612a:
	pop_s r13
