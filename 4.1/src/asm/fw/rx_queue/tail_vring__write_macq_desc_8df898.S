/* tail_vring__write_macq_desc_8df898 @ 0x8df898, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__program_ba_win, vring__wait_drain
 * Зовёт сам: vring__write_macq_desc
 */
	.section .text.tail_vring__write_macq_desc_8df898,"ax",@progbits
	.global tail_vring__write_macq_desc_8df898
tail_vring__write_macq_desc_8df898:
	.global L_8df898
L_8df898:
	mov_s r2,0x1
L_8df89a:
	mov_s r3,0x0
L_8df89c:
	b.d L_8c4768
L_8df8a0:
	mov r4,0x2
