/* init_globals_sweep @ 0x8c0114, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: list_80182c__insert_obj
 */
	.section .text.init_globals_sweep,"ax",@progbits
	.global init_globals_sweep
init_globals_sweep:
L_8c0114:
	st.a blink,[sp,-0x4]
L_8c0118:
	mov_s r0,0x8008f8
L_8c011e:
	bl L_8c1a60
L_8c0122:
	mov_s r0,0x8009a4
L_8c0128:
	bl L_8c1a60
L_8c012c:
	mov_s r0,0x800ae0
L_8c0132:
	bl L_8c1a60
L_8c0136:
	mov_s r0,0x800aec
L_8c013c:
	bl L_8c1a60
L_8c0140:
	mov_s r0,0x800cc4
L_8c0146:
	bl L_8c1a60
L_8c014a:
	mov_s r0,0x800cd0
L_8c0150:
	bl L_8c1a60
L_8c0154:
	mov_s r0,0x800cdc
L_8c015a:
	bl L_8c1a60
L_8c015e:
	mov_s r0,0x800d6c
L_8c0164:
	bl L_8c1a60
L_8c0168:
	mov_s r0,0x800d90
L_8c016e:
	bl L_8c1a60
L_8c0172:
	mov_s r0,0x800f68
L_8c0178:
	bl L_8c1a60
L_8c017c:
	mov_s r0,0x800f74
L_8c0182:
	bl L_8c1a60
L_8c0186:
	mov_s r0,0x800fb0
L_8c018c:
	bl L_8c1a60
L_8c0190:
	mov_s r0,0x8011f4
L_8c0196:
	bl L_8c1a60
L_8c019a:
	mov_s r0,0x801200
L_8c01a0:
	bl L_8c1a60
L_8c01a4:
	mov_s r0,0x801434
L_8c01aa:
	bl L_8c1a60
L_8c01ae:
	mov_s r0,0x801470
L_8c01b4:
	bl L_8c1a60
L_8c01b8:
	mov_s r0,0x80147c
L_8c01be:
	bl L_8c1a60
L_8c01c2:
	mov_s r0,0x801588
L_8c01c8:
	bl L_8c1a60
L_8c01cc:
	mov_s r0,0x801604
L_8c01d2:
	bl L_8c1a60
L_8c01d6:
	mov_s r0,0x80171c
L_8c01dc:
	bl L_8c1a60
L_8c01e0:
	mov_s r0,0x80183c
L_8c01e6:
	bl L_8c1a60
L_8c01ea:
	nop_s
L_8c01ec:
	jl 0x1a40
L_8c01f4:
	ld.ab blink,[sp,0x4]
L_8c01f8:
	j [blink]
