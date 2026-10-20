/* rx_pool__set_fields @ 0x8d6384, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__attach_rx_pool, mid__set_rx_ring
 */
	.section .text.rx_pool__set_fields,"ax",@progbits
	.global rx_pool__set_fields
rx_pool__set_fields:
	.global L_8d6384
L_8d6384:
	st_s r1,[r0]
L_8d6386:
	st_s r2,[r0,0x4]
L_8d6388:
	mov_s r1,0x0
L_8d638a:
	st_s r1,[r0,0x8]
L_8d638c:
	j_s.d [blink]
L_8d638e:
	st_s r1,[r0,0xc]
