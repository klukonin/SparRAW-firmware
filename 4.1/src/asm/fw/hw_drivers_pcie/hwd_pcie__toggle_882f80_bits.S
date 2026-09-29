/* hwd_pcie__toggle_882f80_bits @ 0x8ce85c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__pm_host_config, stats_timer_exp
 */
	.section .text.hwd_pcie__toggle_882f80_bits,"ax",@progbits
	.global hwd_pcie__toggle_882f80_bits
hwd_pcie__toggle_882f80_bits:
	.global L_8ce85c
L_8ce85c:
	mov_s r2,0x882f80
L_8ce862:
	mov_s r1,0x88b080
L_8ce868:
	brne_s r0,0,L_8ce87e
L_8ce86a:
	ld_s r0,[r2,0x8]
L_8ce86c:
	bset_s r0,r0,0x1a
L_8ce86e:
	st_s r0,[r2,0x8]
L_8ce870:
	ld_s r0,[r2,0x8]
L_8ce872:
	bset_s r0,r0,0x1d
L_8ce874:
	st_s r0,[r2,0x8]
L_8ce876:
	ld_s r0,[r1,0x30]
L_8ce878:
	bclr_s r0,r0,0x6
L_8ce87a:
	st_s r0,[r1,0x30]
L_8ce87c:
	b_s L_8ce890
	.global L_8ce87e
L_8ce87e:
	ld_s r0,[r1,0x30]
L_8ce880:
	bset_s r0,r0,0x6
L_8ce882:
	st_s r0,[r1,0x30]
L_8ce884:
	ld_s r0,[r2,0x8]
L_8ce886:
	bclr_s r0,r0,0x1d
L_8ce888:
	st_s r0,[r2,0x8]
L_8ce88a:
	ld_s r0,[r2,0x8]
L_8ce88c:
	bclr_s r0,r0,0x1a
L_8ce88e:
	st_s r0,[r2,0x8]
	.global L_8ce890
L_8ce890:
	j_s [blink]
L_8ce892:
	nop_s
