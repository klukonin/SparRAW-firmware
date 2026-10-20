/* uc_list__insert_by_prio @ 0x9215fc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_boot__init_list_80095c
 * Зовёт сам: list_800b90__insert_sorted
 */
	.section .text.uc_list__insert_by_prio,"ax",@progbits
	.global uc_list__insert_by_prio
uc_list__insert_by_prio:
	.global L_9215fc
L_9215fc:
	push_s blink
L_9215fe:
	ldb_s r1,[r0,0x8]
L_921600:
	bl.d L_92b294
L_921604:
	mov_s r2,0x0
L_921606:
	mov_s r0,0x0
L_921608:
	pop_s blink
L_92160a:
	j_s [blink]
