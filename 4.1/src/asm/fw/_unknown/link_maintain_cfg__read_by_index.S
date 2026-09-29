/* link_maintain_cfg__read_by_index @ 0x8ca13c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_link_maintain_cfg_read
 * Зовёт сам: memcpy_fw
 */
	.section .text.link_maintain_cfg__read_by_index,"ax",@progbits
	.global link_maintain_cfg__read_by_index
link_maintain_cfg__read_by_index:
	.global L_8ca13c
L_8ca13c:
	cmp_s r0,0x8
L_8ca13e:
	push_s blink
L_8ca140:
	mov.cc r0,0x1
L_8ca144:
	bhs_s L_8ca160
L_8ca146:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8ca148:
	add3_s r0,r0,r0
L_8ca14a:
	add r2,r0,0x857060
L_8ca152:
	mov_s r0,r1
L_8ca154:
	add r1,r2,0x1c
L_8ca158:
	bl.d L_8c0460
L_8ca15c:
	mov_s r2,0x24
L_8ca15e:
	mov_s r0,0x0
	.global L_8ca160
L_8ca160:
	pop_s blink
L_8ca162:
	j_s [blink]
