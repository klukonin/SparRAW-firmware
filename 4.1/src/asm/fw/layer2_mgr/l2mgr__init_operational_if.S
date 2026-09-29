/* l2mgr__init_operational_if @ 0x8ed434, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: l2mgr__init_mbox
 */
	.section .text.l2mgr__init_operational_if,"ax",@progbits
	.global l2mgr__init_operational_if
l2mgr__init_operational_if:
	.global L_8ed434
L_8ed434:
	push_s blink
L_8ed436:
	mov_s r1,0x208cc
L_8ed43c:
	mov_s r0,0x804400
L_8ed442:
	bl L_8ed544
L_8ed446:
	mov_s r1,0xa
L_8ed448:
	mov_s r0,0x857000
L_8ed44e:
	st_s r1,[r0,0x50]
L_8ed450:
	pop_s blink
L_8ed452:
	j_s [blink]
